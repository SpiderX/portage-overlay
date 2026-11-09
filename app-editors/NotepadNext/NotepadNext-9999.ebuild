# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake edo git-r3 xdg

QSU_COMMIT="c5c136c0f79ca6423b0914a2676ae3d0e3811c5b"
QADS_COMMIT="023ce95934fecfd4cf5c672c9c404fabe0f54923"
EC_COMMIT="ab62f0554abf2bbe4d45427b36a8b2f81ca7b4ab"
SA_COMMIT="a218603d76a55dddb65b84f2b49ecaa8efc074ea"

DESCRIPTION="A cross-platform reimplementation of Notepad++"
HOMEPAGE="https://github.com/dail8859/NotepadNext"
EGIT_REPO_URI="https://github.com/dail8859/${PN}.git"
SRC_URI="https://github.com/alex-spataru/QSimpleUpdater/archive/${QSU_COMMIT}.tar.gz -> ${PN}-0.15-qsu.tar.gz
	https://github.com/githubuser0xFFFF/Qt-Advanced-Docking-System/archive/${QADS_COMMIT}.tar.gz -> ${PN}-0.15-qads.tar.gz
	https://github.com/editorconfig/editorconfig-core-qt/archive/${EC_COMMIT}.tar.gz -> ${PN}-0.15-ec.tar.gz
	https://github.com/itay-grudev/SingleApplication/archive/${SA_COMMIT}.tar.gz -> ${PN}-0.15-sa.tar.gz"

LICENSE="GPL-3 LGPL-2.1 MIT"
SLOT="0"

DEPEND="dev-qt/qtbase:6[gui,network,widgets]
	dev-qt/qt5compat:6
	x11-libs/libxcb"
RDEPEND="${DEPEND}"
BDEPEND="dev-qt/qttools:6"

PATCHES=( "${FILESDIR}/${PN}"-0.15-optional-appimage.patch )

src_unpack() {
	git-r3_src_unpack
	unpack ${A}
}

src_prepare() {
	edo ln -s ../../QSimpleUpdater-"${QSU_COMMIT}" thirdparty/QSimpleUpdater
	edo ln -s ../../Qt-Advanced-Docking-System-"${QADS_COMMIT}" thirdparty/ads
	edo ln -s ../../editorconfig-core-qt-"${EC_COMMIT}" thirdparty/editorconfig_core_qt
	edo ln -s ../../SingleApplication-"${SA_COMMIT}" thirdparty/SingleApplication

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		# link bundled third-party libraries statically
		-DBUILD_SHARED_LIBS=OFF
		# prevent unnecessary RPATH/RUNPATH entries in the installed executable.
		-DCMAKE_SKIP_INSTALL_RPATH=ON
		-DFETCHCONTENT_SOURCE_DIR_ADS="${S}/thirdparty/ads"
		-DFETCHCONTENT_SOURCE_DIR_QSIMPLEUPDATER="${S}/thirdparty/QSimpleUpdater"
		-DFETCHCONTENT_SOURCE_DIR_EDITORCONFIG_CORE_QT="${S}/thirdparty/editorconfig_core_qt"
		-DFETCHCONTENT_SOURCE_DIR_SINGLEAPPLICATION="${S}/thirdparty/SingleApplication"
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install

	# remove development files from the bundled static ADS library.
	rm -f "${ED}/usr/$(get_libdir)/libqtadvanceddocking-qt6_static.a" || die
	rm -rf "${ED}/usr/$(get_libdir)/cmake/qtadvanceddocking-qt6" || die
	rm -rf "${ED}/usr/include/qtadvanceddocking-qt6" || die
}
