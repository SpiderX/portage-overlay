# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools git-r3 tmpfiles

DESCRIPTION="Terminal I/O logger"
HOMEPAGE="https://github.com/Scribery/tlog"
EGIT_REPO_URI="https://github.com/Scribery/${PN}.git"

LICENSE="GPL-2"
SLOT="0"
IUSE="debug systemd utempter"
RESTRICT="test" # can't run in sandbox

RDEPEND="acct-group/tlog
	acct-user/tlog
	dev-libs/json-c
	net-misc/curl
	systemd? ( sys-apps/systemd:= )
	!systemd? ( sys-apps/systemd-utils )
	utempter? ( sys-libs/libutempter )"
BDEPEND="virtual/pkgconfig"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf "$(use_enable debug)" "$(use_enable systemd journal)" \
		"$(use_enable utempter)"
}

src_install() {
	default

	newtmpfiles "${FILESDIR}"/tlog.tmpfile tlog.conf
	find "${D}" -name '*.la' -delete || die "find failed"
}

pkg_postinst() {
	tmpfiles_process tlog.conf
}
