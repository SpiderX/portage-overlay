# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="${PN/-bin/}"
MY_PV="${PV}a"
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="SNMP traffic monitor in realtime"
HOMEPAGE="https://wtraf.sourceforge.net/"
SRC_URI="mirror://sourceforge/${MY_PN}/nix%20binaries/${MY_P}.tar.gz"

LICENSE="Unlicense"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="bindist mirror"

S="${WORKDIR}"

src_install() {
	dobin wtraf
}
