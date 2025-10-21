# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="Music player for big local collections"
HOMEPAGE="https://mpz-player.org"
SRC_URI="https://github.com/olegantonyan/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-cpp/yaml-cpp:=
	dev-qt/qtbase:6[concurrent,dbus,gui,network,widgets]
	dev-qt/qtmultimedia:6
	media-libs/taglib:="
DEPEND="${RDEPEND}"

DOCS=( {CHANGELOG,README}.md )

src_configure() {
	local mycmakeargs=(
		-DUSE_SYSTEM_TAGLIB=ON
		-DUSE_SYSTEM_YAMLCPP=ON
	)
	cmake_src_configure
}

src_install() {
	dolib.so "${S}"_build/libqtwaitingspinner.so
	dolib.so "${S}"_build/3rdparty/QHotkey-1.5.0/libqhotkey.so.1.5.0
	dosym ./libqhotkey.so.1.5.0 usr/"$(get_libdir)"/libqhotkey.so.1
	dosym ./libqhotkey.so.1.5.0 usr/"$(get_libdir)"/libqhotkey.so

	cmake_src_install
}
