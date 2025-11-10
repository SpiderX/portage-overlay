# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN}-image-plugin"

inherit cmake edo

DESCRIPTION="Qt plugin for HEIF images"
HOMEPAGE="https://github.com/jakar/qt-heif-image-plugin"
SRC_URI="https://github.com/jakar/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="LGPL-3+"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-qt/qtbase:6[gui]
	media-libs/libheif:="
BDEPEND="virtual/pkgconfig"

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	# https://github.com/jakar/qt-heif-image-plugin/issues/27
	edo cp -f "${FILESDIR}"/CMakeLists.txt src
	cmake_src_prepare
}
