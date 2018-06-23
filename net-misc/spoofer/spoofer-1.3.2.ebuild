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
	enewgroup "${PN}"
	enewuser "${PN}" -1 -1 /var/lib/"${PN}" "${PN}"
}

# Unable to stop binaries stripping :(
QA_PRESTRIPPED="usr/bin/spoofer-\\(cli\\|gui\\|scheduler\\)"

src_prepare() {
	default
	eautoreconf

	# Attempt to not strip binaries
	#sed -i '/stripprog=/s/\${STRIPPROG-strip}/echo/' build-aux/install-sh
	#sed -i '/.MAKE:/s/install-strip//' Makefile.in
	#sed -i '/install-ps-am/s/install-strip//' Makefile.in
	#sed -i '/INSTALL_STRIP_PROGRAM=/s/ -s//' {configure,aclocal.m4} \
	#	|| die "sed failed for configure"
	#sed -i 's/INSTALL_STRIP_FLAG=-s//' {common/,manager/,prober/,}Makefile.in
	#eautoreconf
}

src_install() {
	default

	newinitd "${FILESDIR}"/"${PN}"-prober.initd "${PN}"-prober
	newconfd "${FILESDIR}"/"${PN}"-prober.confd "${PN}"-prober
	systemd_dounit "${FILESDIR}"/"${PN}"-prober.service
	newtmpfiles "${FILESDIR}"/"${PN}".tmpfile "${PN}".conf

	if use qt5 ; then
		make_desktop_entry "${PN}-gui" "${PN^}" "${PN}" "Network;Qt"

		insinto /etc/xdg/CAIDA
		doins "${FILESDIR}"/"${PN^}".conf
		fowners "${PN}":"${PN}" /etc/xdg/CAIDA/"${PN^}".conf

		keepdir /var/lib/"${PN}"/
		fowners -R "${PN}":"${PN}" /var/lib/"${PN}"/

		newinitd "${FILESDIR}"/"${PN}".initd "${PN}"
		newconfd "${FILESDIR}"/"${PN}".confd "${PN}"
		systemd_dounit "${FILESDIR}"/"${PN}".service
	fi
}

pkg_postinst() {
	tmpfiles_process "${PN}".conf
}
