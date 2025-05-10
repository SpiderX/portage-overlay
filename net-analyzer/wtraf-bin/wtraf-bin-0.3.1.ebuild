# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN/-bin/}"
MY_PV="${PV}a"
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="SNMP traffic monitor in realtime"
HOMEPAGE="https://sourceforge.net/projects/wtraf/"
SRC_URI="https://downloads.sourceforge.net/project/${MY_PN}/nix%20binaries/${MY_P}.tar.gz"
S="${WORKDIR}"

LICENSE="Unlicense"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="bindist mirror"

src_install() {
	dobin wtraf
}
