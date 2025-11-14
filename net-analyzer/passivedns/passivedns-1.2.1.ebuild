# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools systemd

DESCRIPTION="Network sniffer that logs all DNS server replies"
HOMEPAGE="https://github.com/gamelinux/passivedns"
SRC_URI="https://github.com/gamelinux/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug json ssl"

RDEPEND="acct-group/passivedns
	acct-user/passivedns
	net-libs/ldns:0=
	net-libs/libpcap
	json? ( dev-libs/jansson:0= )
	ssl? ( dev-libs/openssl:0= )"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}/${PN}"-1.2.1-pcap.patch
	"${FILESDIR}/${PN}"-1.2.1-gcc10.patch )

DOCS=( doc/{ChangeLog,How-it-works.txt,ISSUES} )

src_prepare() {
	default

	# respect CFLAGS
	sed -i "/\$(CC)/s/-O3/\$(CFLAGS)/" src/Makefile.am || die "sed failed"
	eautoreconf
}

src_configure() {
	econf "$(use_enable debug)" "$(use_enable json)"
}

src_install() {
	default

	newinitd "${FILESDIR}"/passivedns.initd passivedns
	newconfd "${FILESDIR}"/passivedns.confd passivedns
	systemd_dounit "${FILESDIR}"/passivedns.service
}
