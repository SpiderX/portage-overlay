# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_4,3_5} )

inherit cmake-utils python-single-r1

DESCRIPTION="Screenshot capturing and sharing tool over various services"
HOMEPAGE="https://screencloud.net/"
SRC_URI="https://github.com/olav-st/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
DOCS=( README.md )
IUSE=""

DEPEND="dev-libs/quazip
	dev-python/PythonQt[extensions]
	dev-qt/qtmultimedia:5[widgets]
	dev-qt/qtconcurrent:5
	dev-qt/qtnetwork:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	dev-qt/qtxml:5
	"
#	dev-python/PythonQt["${PYTHON_USEDEP}",extensions]?
RDEPEND="${DEPEND}
	dev-libs/openssl"

src_prepare() {
	cmake-utils_src_prepare
	default
}

src_configure() {
	local mycmakeargs=(
		-DPYTHON_USE_PYTHON3="$(usex python_single_target_python2_7 OFF ON)"
	)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
}
