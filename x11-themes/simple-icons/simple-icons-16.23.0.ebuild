# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PV="${PV//./-}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="SVG icons for popular brands"
HOMEPAGE="https://github.com/simple-icons/simple-icons"
SRC_URI="https://github.com/simple-icons/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="CC0-1.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_install() {
	insinto /usr/share/icons/simple-icons/scalable
	doins -r icons/.
}
