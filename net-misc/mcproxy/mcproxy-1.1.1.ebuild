# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit linux-info qmake-utils systemd

DESCRIPTION="IGMP/MLD Proxy daemon"
HOMEPAGE="https://mcproxy.realmv6.org/ https://github.com/mcproxy/mcproxy"
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="dev-qt/qtcore:5"

CONFIG_CHECK="~IP_MULTICAST ~IP_MROUTE"

src_prepare() {
	default

	# Modify install path
	sed -i "/target.path/s|/usr/local|${ED%/}/usr|" "${PN}"/"${PN}".pro \
		|| die "sed failed to modify install path for mcproxy.pro"
}

src_configure() {
	cd "${PN}" || die "failed to change directory to mcproxy"
	eqmake5 CONFIG+="$(usev debug)" "${PN}".pro
}

src_compile() {
	cd "${PN}" || die "failed to change directory to mcproxy"
	emake
}

src_install() {
	einstalldocs

	insinto /etc
	doins "${PN}"/mcproxy.conf

	cd "${PN}" || die "failed to change directory to mcproxy"
	emake DESTDIR="${D}" install

	newinitd "${FILESDIR}"/"${PN}".initd "${PN}"
	newconfd "${FILESDIR}"/"${PN}".confd "${PN}"
	systemd_dounit "${FILESDIR}"/"${PN}".service
}
