# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils xdg

QSU_COMMIT="3cc832cbe55b70c54f56a0b9b6f2cdd3c43c2337"
QADS_COMMIT="5edbcc1970bc8858ad09a41f4c3ac1700e489c8b"
EC_COMMIT="52820d59769fcba6d0ed94f685406c0383fe1a30"
SA_COMMIT="8c48163c4d3fbba603cfe8a5b94046c9dad71825"
UC_COMMIT="edae8e81cfb8092496f94da1a306c4c9f0ce32bb"

DESCRIPTION="A cross-platform reimplementation of Notepad++"
HOMEPAGE="https://github.com/dail8859/NotepadNext"
SRC_URI="https://github.com/dail8859/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/alex-spataru/QSimpleUpdater/archive/${QSU_COMMIT}.tar.gz -> ${P}-qsu.tar.gz
	https://github.com/githubuser0xFFFF/Qt-Advanced-Docking-System/archive/${QADS_COMMIT}.tar.gz -> ${P}-qads.tar.gz
	https://github.com/editorconfig/editorconfig-core-qt/archive/${EC_COMMIT}.tar.gz -> ${P}-ec.tar.gz
	https://github.com/itay-grudev/SingleApplication/archive/${SA_COMMIT}.tar.gz -> ${P}-sa.tar.gz
	https://gitlab.freedesktop.org/uchardet/uchardet/-/archive/${UC_COMMIT}.tar.gz -> ${P}-uc.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-qt/qtbase:6[gui,network,widgets]
	dev-qt/qt5compat:6"
BDEPEND="dev-qt/qttools:6"

src_prepare() {
	default

	rmdir src/{QSimpleUpdater,ads,editorconfig-core-qt,singleapplication,uchardet} \
		|| die "rmdir failed for src"
	ln -s ../../QSimpleUpdater-"${QSU_COMMIT}" src/QSimpleUpdater \
		|| die "ln failed for QSimpleUpdater"
	ln -s ../../Qt-Advanced-Docking-System-"${QADS_COMMIT}" src/ads \
		|| die "ln failed for ads"
	ln -s ../../editorconfig-core-qt-"${EC_COMMIT}" src/editorconfig-core-qt \
		|| die "ln failed for editorconfig-core-qt"
	ln -s ../../SingleApplication-"${SA_COMMIT}" src/singleapplication \
		|| die "ln failed for singleapplication"
	ln -s ../../uchardet-"${UC_COMMIT}" src/uchardet \
		|| die "ln failed for uchardet"
}

src_configure() {
	eqmake6 src/NotepadNext.pro
}

src_install() {
	einstalldocs
	emake INSTALL_ROOT="${ED}" install
}
