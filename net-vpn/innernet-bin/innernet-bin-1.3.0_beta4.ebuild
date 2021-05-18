# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit pax-utils systemd unpacker

MY_PN="${PN/-bin/}"
MY_PV="${PV/_beta/.beta.}"
MY_P="${MY_PN}-${MY_PV}"
MY_PVR=$(ver_rs 3 - "$MY_PV")

DESCRIPTION="WireGuard based private network system"
HOMEPAGE="https://github.com/tonarino/innernet"
SRC_URI="client? ( https://github.com/tonarino/${MY_PN}/releases/download/v${MY_PVR}/${MY_P/-/_}_amd64.deb )
	server? ( https://github.com/tonarino/${MY_PN}/releases/download/v${MY_PVR}/${MY_PN}-server_${MY_PV}_amd64.deb )"

LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="+client server"
REQUIRED_USE="|| ( client server )"
RESTRICT="bindist mirror"

RDEPEND="dev-db/sqlite:3
	sys-libs/zlib:="

S="${WORKDIR}"

QA_PREBUILT="usr/bin/innernet
	/usr/bin/innernet-server"
QA_FLAGS_IGNORED="usr/bin/innernet
	usr/bin/innernet-server"

src_unpack() {
	unpacker_src_unpack

	use client && unpack usr/share/man/man8/innernet.8.gz
	use server && unpack usr/share/man/man8/innernet-server.8.gz
}

src_install() {
	if use client ; then
		doman innernet.8
		dobin usr/bin/innernet
		pax-mark m "${ED}"/usr/bin/innernet
		dosym ../bin/innernet usr/bin/inn
		newinitd "${FILESDIR}"/innernet-client.initd innernet-client
		newconfd "${FILESDIR}"/innernet-client.confd innernet-client
		systemd_dounit usr/lib/systemd/system/innernet@.service
	fi
	if use server ; then
		doman innernet-server.8
		dobin usr/bin/innernet-server
		pax-mark m "${ED}"/usr/bin/innernet-server
		newinitd "${FILESDIR}"/innernet-server.initd innernet-server
		newconfd "${FILESDIR}"/innernet-server.confd innernet-server
		systemd_dounit usr/lib/systemd/system/innernet-server@.service
	fi
}
