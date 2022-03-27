# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://gitlab.com/gitlab-org/${PN}.git"

inherit git-r3 go-module systemd tmpfiles

DESCRIPTION="Git RPC service for handling GitLab git calls"
HOMEPAGE="https://gitlab.com/gitlab-org/gitaly"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""
RESTRICT="mirror test" # network-sandbox

RDEPEND="acct-user/gitlab-gitaly
	app-admin/logrotate"
DEPEND="dev-ruby/bundler:="
BDEPEND="dev-util/cmake"

DOCS=( {CHANGELOG,README}.md )

QA_PREBUILT="/var/lib/gitlab-gitaly/ruby/vendor/bundle/ruby/2.5.0/gems/grpc-tools-1.0.1/bin/x86-linux/grpc_ruby_plugin
	/var/lib/gitlab-gitaly/ruby/vendor/bundle/ruby/2.5.0/gems/grpc-tools-1.0.1/bin/x86-linux/protoc
	/var/lib/gitlab-gitaly/ruby/vendor/bundle/ruby/2.5.0/gems/grpc-tools-1.0.1/bin/x86_64-linux/grpc_ruby_plugin
	/var/lib/gitlab-gitaly/ruby/vendor/bundle/ruby/2.5.0/gems/grpc-tools-1.0.1/bin/x86_64-linux/protoc"

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_prepare() {
	default

	# https://github.com/rubys/nokogumbo/issues/40#issuecomment-182667202
	pushd ruby || die "pushd failed"
	bundle config build.nokogumbo --with-ldflags='-Wl,--undefined' || die "bundle failed"
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
	rmdir "${ED}"/var/lib/gitlab-gitaly/ruby/vendor/bundle/ruby/2.5.0/doc \
		"${ED}"/var/lib/gitlab-gitaly/ruby/vendor/bundle/ruby/2.5.0/gems/nokogiri-1.10.9/ext/nokogiri/tmp/x86_64-pc-linux-gnu \
		"${ED}"/var/lib/gitlab-gitaly/ruby/vendor/bundle/ruby/2.5.0/gems/nokogiri-1.10.9/ext/nokogiri/tmp \
		"${ED}"/var/lib/gitlab-gitaly/ruby/vendor/bundle/ruby/2.5.0/gems/nokogiri-1.10.9/ports/x86_64-pc-linux-gnu/libxslt/1.1.34/lib/libxslt-plugins \
		"${ED}"/var/lib/gitlab-gitaly/ruby/vendor/bundle/ruby/2.5.0/gems/rugged-0.28.4.1/vendor/libgit2/build/CMakeFiles/3.16.5/CompilerIdC/tmp \
		"${ED}"/var/lib/gitlab-gitaly/ruby/vendor/bundle/ruby/2.5.0/gems/rugged-0.28.4.1/vendor/libgit2/build/CMakeFiles/CMakeTmp \
		|| die "rmdir failed"

	# Strict permissions on world writable files
	find "${ED}"/var/lib/gitlab-gitaly/ruby/vendor/bundle/ruby/2.5.0/gems/gitlab-labkit-0.12.0 -type f -exec chmod 644 {} \; \
		|| die "find failed"

	insopts -o gitlab-gitaly -g gitlab -m 0600
	insinto /etc/gitlab-gitaly
	doins config.toml.example

	diropts -o gitlab-gitaly -g gitlab -m 0700
	keepdir /var/log/gitlab-gitaly
}

pkg_postinst() {
	tmpfiles_process gitlab-gitaly.conf
}
