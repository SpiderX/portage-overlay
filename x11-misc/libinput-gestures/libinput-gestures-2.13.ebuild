# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python{3_4,3_5} )

inherit python-single-r1

DESCRIPTION="Actions gestures on your touchpad using libinput"
HOMEPAGE="https://github.com/bulletmark/${PN}"
SRC_URI="https://github.com/bulletmark/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="${PYTHON_DEPS}
	x11-misc/xdotool
	x11-misc/wmctrl
	dev-libs/libinput"

# Fix keyword-only placement
PATCHES=( "${FILESDIR}/${P}-keyword.patch" )

pkg_postinst() {
	elog "You must be in the input group to read the touchpad device."
}
