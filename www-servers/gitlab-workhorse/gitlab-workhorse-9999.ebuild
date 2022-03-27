# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://gitlab.com/gitlab-org/${PN}.git"
EGIT_SUBMODULES=()

inherit git-r3 go-module systemd tmpfiles

DESCRIPTION="GitLab reverse proxy"
HOMEPAGE="https://gitlab.com/gitlab-org/gitlab-workhorse"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="test"
RESTRICT="!test? ( test ) mirror"

RDEPEND="acct-user/gitlab-workhorse
	media-libs/exiftool"

DOCS=( CHANGELOG README.md )

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor

	if use test ; then
		git-r3_checkout https://gitlab.com/gitlab-org/gitlab-test.git \
			"${WORKDIR}/${P}"/testdata/data/group/test.git
	fi
}

src_install() {
	einstalldocs
	emake PREFIX="${ED}"/usr install

	insinto /etc/logrotate.d
	newins "${FILESDIR}"/gitlab-workhorse.logrotate gitlab-workhorse

	newinitd "${FILESDIR}"/gitlab-workhorse.initd gitlab-workhorse
	newconfd "${FILESDIR}"/gitlab-workhorse.confd gitlab-workhorse
	systemd_dounit "${FILESDIR}"/gitlab-workhorse.service
	newtmpfiles "${FILESDIR}"/gitlab-workhorse.tmpfile gitlab-workhorse.conf

	insopts -o gitlab-workhorse -g gitlab -m 0600
	insinto /etc/gitlab-workhorse
	doins config.toml.example

	diropts -o gitlab-workhorse -g gitlab -m 0700
	keepdir /var/log/gitlab-workhorse
}

pkg_postinst() {
	tmpfiles_process gitlab-workhorse.conf
}
