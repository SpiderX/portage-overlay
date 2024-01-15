# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby27 ruby30 ruby31"
EGIT_REPO_URI="https://gitlab.com/gitlab-org/${PN}.git"

inherit git-r3 go-module ruby-single systemd tmpfiles

DESCRIPTION="Git RPC service for handling GitLab git calls"
HOMEPAGE="https://gitlab.com/gitlab-org/gitaly"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""
RESTRICT="mirror test"

RDEPEND="${RUBY_DEPS}
	acct-group/gitlab
	acct-user/gitlab-gitaly
	${DEPEND}"
DEPEND="dev-libs/gmp:=
	dev-libs/icu:=
	dev-libs/libffi:=
	dev-libs/libgpg-error
	dev-libs/libpcre2:=
	dev-libs/libxml2:2
	dev-libs/libxslt
	sys-libs/libxcrypt:="
BDEPEND="dev-ruby/bundler:2
	dev-build/cmake
	virtual/pkgconfig"

DOCS=( {CHANGELOG,README}.md )

pkg_setup() {
	einfo "This package fetches gems during compilation."
	einfo "Therefore network-sandbox feature (man 5 make.conf) must be disabled for it:"
	einfo " echo 'FEATURES=\"-network-sandbox\"' > /etc/portage/env/no-network-sandbox.conf"
	einfo " echo 'dev-vcs/gitaly no-network-sandbox.conf'/etc/portage/package.env/gitaly"
}

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_prepare() {
	default

	pushd ruby || die "pushd failed"
	bundle config set build.nokogiri --use-system-libraries || die "bundle nokogiri failed"
	bundle config set build.rugged --use-system-libraries || die "bundle rugged failed"
	popd || die "popd failed"

	# Modify config (socket_path, bin_dir, dir in gitlab-gitaly and gitlab-shell sections)
	sed -i \
		-e '/socket_path/s|home/git/gitlab/tmp/sockets/private/|run/gitlab-gitaly/gitlab-|' \
		-e '/bin_dir/s|home/git/gitaly|usr/bin|' \
		-e '/^path/s|home|var/lib|' \
		-e '/dir = "\/home\/git\/gitaly\//s|home/git/gitaly|var/lib/gitlab-gitaly|' \
		-e '/dir = "\/home\/git\/gitlab-shell/s|home|var/lib|' \
		config.toml.example || die "sed failed for config.toml.example"
}

src_install() {
	einstalldocs
	emake PREFIX="${ED}"/usr install

	newconfd "${FILESDIR}"/gitlab-gitaly.confd gitlab-gitaly
	newinitd "${FILESDIR}"/gitlab-gitaly.initd gitlab-gitaly
	systemd_dounit "${FILESDIR}"/gitlab-gitaly.service
	newtmpfiles "${FILESDIR}"/gitlab-gitaly.tmpfile gitlab-gitaly.conf

	insinto /etc/logrotate.d
	newins "${FILESDIR}"/gitlab-gitaly.logrotate gitlab-gitaly

	# Install gitaly-ruby
	diropts -o gitlab-gitaly -g gitlab -m 0755
	insinto /var/lib/gitlab-gitaly
	cp -a ruby "${ED}"/var/lib/gitlab-gitaly/ruby || die "cp failed"
	fowners -R gitlab-gitaly:gitlab /var/lib/gitlab-gitaly/ruby

	# Remove empty directories
	rmdir "${ED}"/var/lib/gitlab-gitaly/ruby/vendor/bundle/ruby/"$(ruby -v | cut -c 6-9)"0/{doc,plugins} \
		|| die "rmdir failed"

	# Strict permissions on world writable files
	find "${ED}"/var/lib/gitlab-gitaly/ruby/vendor/bundle/ruby/"$(ruby -v | cut -c 6-9)"0/gems/gitlab-labkit-0.16.2 \
		-type f -exec chmod 644 {} \; || die "find failed"

	insopts -o gitlab-gitaly -g gitlab -m 0600
	insinto /etc/gitlab-gitaly
	doins config.toml.example

	diropts -o gitlab-gitaly -g gitlab -m 0700
	keepdir /var/log/gitlab-gitaly
}

pkg_postinst() {
	tmpfiles_process gitlab-gitaly.conf
}
