# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake readme.gentoo-r1 virtualx

DESCRIPTION="An apng image plugin for Qt to support animated PNGs"
HOMEPAGE="https://github.com/jurplel/QtApng"
SRC_URI="https://github.com/jurplel/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="test" # 4 tests fail

RDEPEND="dev-qt/qtbase:6[gui,widgets]
	media-libs/libpng:0=[apng]"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

DOC_CONTENTS="Since the png format is already used by Qt,
*.png files will not use the plugin. Rename the file to *.apng
to load a png as animated\\n"

src_configure() {
	local mycmakeargs=(
		-DAPNG_TESTS="$(usex test true false)"
	)
	cmake_src_configure
}

src_test() {
	virtx "${S}"_build/ApngTests
}

src_install() {
	exeinto /usr/"$(get_libdir)"/qt6/plugins/imageformats
	doexe "${S}"_build/plugins/imageformats/libqapng.so
	cmake_src_install
	readme.gentoo_create_doc
}

pkg_postinst() {
	readme.gentoo_print_elog
}
