# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils virtualx

DESCRIPTION="An apng image plugin for Qt to support animated PNGs"
HOMEPAGE="https://github.com/Skycoder42/QtApng"
SRC_URI="https://github.com/Skycoder42/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-qt/qtcore:5
	dev-qt/qtgui:5
	media-libs/libpng:0=[apng]"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig
	test? ( dev-qt/qttest:5 )"

src_configure() {
	eqmake5 "CONFIG+=system_libpng"
}

src_test() {
	pushd tests || die "pushd failed"
	eqmake5
	emake
	virtx ./auto/apng/apngPlugin/tst_apngplugin || die "tests failed"
	popd || die "popd failed"
}

src_install() {
	einstalldocs
	emake INSTALL_ROOT="${ED}" install
}
