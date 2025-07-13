# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PV="${PV//./-}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Vimix-cursors for linux desktop"
HOMEPAGE="https://github.com/vinceliuice/Vimix-cursors"
SRC_URI="https://github.com/vinceliuice/${PN}/archive/${MY_PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_install() {
	insinto /usr/share/icons/Vimix-cursors
	doins -r dist/.
	insinto /usr/share/icons/Vimix-cursors-white
	doins -r dist-white/.
}
