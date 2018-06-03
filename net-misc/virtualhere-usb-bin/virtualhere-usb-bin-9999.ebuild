# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

CLIENT_URI="https://virtualhere.com/sites/default/files/usbclient/vh_arch_"
SERVER_URI="https://virtualhere.com/sites/default/files/usbserver/vh_arch_"

inherit linux-info user

DESCRIPTION="Share USB devices over the network"
HOMEPAGE="https://virtualhere.com/"
SRC_URI="client? (
		amd64? ( ${CLIENT_URI/_arch_/clientx86_64} )
		arm?   ( ${CLIENT_URI/_arch_/clientarmhf} )
		x86?   ( ${CLIENT_URI/_arch_/clienti386} )
	)
	gui? (
		amd64? ( ${CLIENT_URI/_arch_/uit64} )
		arm?   ( ${CLIENT_URI/_arch_/uitarm7} )
		x86?   ( ${CLIENT_URI/_arch_/uit32} )
	)
	server? (
		amd64? ( ${SERVER_URI/_arch_/usbdx86_64} )
		arm?   ( ${SERVER_URI/_arch_/usbdarm} )
		arm64? ( ${SERVER_URI/_arch_/usbdarm64} )
		mips?  ( ${SERVER_URI/_arch_/usbdmips} )
		x86?   ( ${SERVER_URI/_arch_/usbdi386} )
	)"
LICENSE="openssl no-source-code"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~mips ~x86"
IUSE="client gui server"
REQUIRED_USE="|| ( client gui server )"

DEPEND="virtual/linux-sources"

S="${WORKDIR}"

QA_PREBUILT="/opt/vhusb/vhclient*
	/opt/vhusb/vhuit*
	/opt/vhusb/vhusbd*"

pkg_setup() {
	enewgroup vhusb
	enewuser vhusb -1 -1 /opt/vhusb vhusb

	use client && CONFIG_CHECK="~USBIP_VHCI_HCD"
	use gui    && CONFIG_CHECK="~USBIP_VHCI_HCD"
	use server && CONFIG_CHECK="~USBIP_HOST"

	linux-info_pkg_setup
}

src_unpack() {
	for AFILE in ${A}; do
		cp "${DISTDIR}"/"${AFILE}" "${S}" || die "copy failed for ${AFILE}"
	done
}

src_install() {
	exeinto /opt/vhusb
	insinto /opt/vhusb

	use gui && doexe vhuit*

	if use client ; then
		doexe vhclient*
		newconfd "${FILESDIR}"/vhusb-client.confd vhusb-client
		use amd64 && newinitd "${FILESDIR}"/vhusb-client.amd64 vhusb-client
		use arm   && newconfd "${FILESDIR}"/vhusb-client.arm   vhusb-client
		use x86   && newconfd "${FILESDIR}"/vhusb-client.x86   vhusb-client
	fi

	if use server ; then
		doexe vhusbd*
		doins "${FILESDIR}"/config.ini
		newconfd "${FILESDIR}"/vhusb-server.confd vhusb-server
		use amd64 && newinitd "${FILESDIR}"/vhusb-server.amd64 vhusb-server
		use arm   && newinitd "${FILESDIR}"/vhusb-server.arm   vhusb-server
		use arm64 && newinitd "${FILESDIR}"/vhusb-server.arm64 vhusb-server
		use mips  && newinitd "${FILESDIR}"/vhusb-server.mips  vhusb-server
		use x86   && newinitd "${FILESDIR}"/vhusb-server.x86   vhusb-server
	fi
}
