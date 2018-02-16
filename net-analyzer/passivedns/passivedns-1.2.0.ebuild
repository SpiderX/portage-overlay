# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools systemd user

DESCRIPTION="Network sniffer that logs all DNS server replies"
HOMEPAGE="https://github.com/gamelinux/passivedns"
SRC_URI="https://github.com/gamelinux/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug json libressl ssl" #pfring

RDEPEND="net-libs/ldns[libressl?]
	net-libs/libpcap
	json? ( dev-libs/jansson )
	ssl? (
		libressl? ( dev-libs/libressl )
		!libressl? ( dev-libs/openssl:0= )
	)"
DEPEND="${RDEPEND}"

DOCS=( doc/AUTHORS doc/ChangeLog doc/How-it-works.txt doc/ISSUES )

src_prepare() {
	default

	# Respect CFLAGS
	sed -i '/$(CC)/s/-O3/$(CFLAGS)/' src/Makefile.am || die "sed failed"
	eautoreconf
}

src_configure() {
	econf \
		"$(use_enable debug)" \
		"$(use_enable json)"
		#$(use_enable pfring )
}

src_install() {
	default

	newinitd "${FILESDIR}"/"${PN}".initd "${PN}"
	newconfd "${FILESDIR}"/"${PN}".confd "${PN}"
	systemd_dounit "${FILESDIR}"/"${PN}".service
}

pkg_postinst() {
	enewgroup "${PN}"
	enewuser "${PN}" -1 -1 /dev/null "${PN}"
}
