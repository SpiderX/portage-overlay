# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="PSD & PSB Plugin for Qt/C++"
HOMEPAGE="https://github.com/roniemartinez/libqpsd"
SRC_URI="https://github.com/roniemartinez/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1+"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-qt/qtbase:6[gui]"

src_prepare() {
	sed -i '/QT_QMAKE_EXECUTABLE/s|qmake-qt5|qmake6|' CMakeLists.txt \
		|| die "sed failed for CMakeLists.txt"
	cmake_src_prepare
}
