# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..7} )

inherit cmake python-single-r1 xdg

DESCRIPTION="Screenshot capturing and sharing tool over various services"
HOMEPAGE="https://screencloud.net"
SRC_URI="https://github.com/olav-st/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="libressl"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="dev-libs/quazip
	>=dev-python/PythonQt-3.2[${PYTHON_SINGLE_USEDEP},extensions]
	dev-qt/qtmultimedia:5[widgets]
	dev-qt/qtconcurrent:5
	dev-qt/qtnetwork:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	dev-qt/qtxml:5"
RDEPEND="${DEPEND}
	${PYTHON_DEPS}
	!libressl? ( dev-libs/openssl:0= )
	libressl? ( dev-libs/libressl:0= )"

src_prepare() {
	cmake_src_prepare
}
