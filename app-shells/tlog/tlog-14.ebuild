# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools tmpfiles

DESCRIPTION="Terminal I/O logger"
HOMEPAGE="https://github.com/Scribery/tlog"
SRC_URI="https://github.com/Scribery/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
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
