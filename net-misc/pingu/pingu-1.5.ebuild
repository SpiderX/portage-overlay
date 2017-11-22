# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs

DESCRIPTION="Policy routing daemon with failover and load-balancing"
HOMEPAGE="https://github.com/ncopa/pingu"
SRC_URI="https://github.com/ncopa/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc"

RDEPEND="dev-libs/libev"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( app-text/asciidoc )"

PATCHES=( "${FILESDIR}"/${P}-configure.patch
	"${FILESDIR}"/${P}-icmp.patch )

src_configure() {
	econf $(use_enable debug) $(use_enable doc)
}

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	default

	newinitd "${FILESDIR}"/${PN}.initd ${PN}
	newconfd "${FILESDIR}"/${PN}.confd ${PN}
	keepdir /etc/pingu
	insinto /etc/pingu
	newins pingu.conf pingu.conf.example
}
