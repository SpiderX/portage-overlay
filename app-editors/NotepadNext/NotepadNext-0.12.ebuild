# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils xdg

QSU_COMMIT="8e7017f7fbdc2b4b1a26ed1eef9ebcba6a50639c"
QADS_COMMIT="c020f82a6cfc43e7127e315b1a8f0e05e8a7113f"
EC_COMMIT="ab62f0554abf2bbe4d45427b36a8b2f81ca7b4ab"
SA_COMMIT="494772e98cef0aa88124f154feb575cc60b08b38"
UC_COMMIT="9699dfce074fac80d8d622f02ea6d8bb2f55cf00"

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
