# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools desktop systemd tmpfiles user

DESCRIPTION="A tool to assess of deployment of source address validation"
HOMEPAGE="https://spoofer.caida.org"
SRC_URI="https://www.caida.org/projects/${PN}/downloads/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="libressl qt5"

CDEPEND="dev-libs/protobuf-c:=
	net-libs/libpcap
	!libressl? ( dev-libs/openssl:0= )
	libressl? ( dev-libs/libressl:0= )
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtnetwork:5
		dev-qt/qtgui:5
		dev-qt/qtwidgets:5
	)"
RDEPEND="${CDEPEND}
	net-analyzer/traceroute"
DEPEND="${CDEPEND}
	virtual/pkgconfig"

pkg_setup() {
	enewgroup spoofer
	enewuser spoofer -1 -1 /var/lib/spoofer spoofer
}

# Unable to stop binaries stripping :(
QA_PRESTRIPPED="usr/bin/spoofer-\\(cli\\|gui\\|scheduler\\)"

src_prepare() {
	default
	eautoreconf
}

src_install() {
	default

	newinitd "${FILESDIR}"/spoofer-prober.initd spoofer-prober
	newconfd "${FILESDIR}"/spoofer-prober.confd spoofer-prober
	systemd_dounit "${FILESDIR}"/spoofer-prober.service
	newtmpfiles "${FILESDIR}"/spoofer.tmpfile spoofer.conf

	if use qt5 ; then
		newinitd "${FILESDIR}"/spoofer.initd spoofer
		newconfd "${FILESDIR}"/spoofer.confd spoofer
		systemd_dounit "${FILESDIR}"/spoofer.service

		make_desktop_entry spoofer-gui Spoofer spoofer "Network;Qt"

		insopts -ospoofer -gspoofer -m0644
		insinto /etc/xdg/CAIDA
		doins "${FILESDIR}"/Spoofer.conf

		diropts -ospoofer -gspoofer -m0700
		keepdir /var/lib/spoofer
	fi
}

pkg_postinst() {
	tmpfiles_process spoofer.conf
}
