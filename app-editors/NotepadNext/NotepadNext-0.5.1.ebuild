# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils xdg

QSU_COMMIT="62e0ce7"
QADS_COMMIT="d5fefaa"
EC_COMMIT="52820d5"
SA_COMMIT="d0c43a5"
UC_COMMIT="59f68db"

DESCRIPTION="A cross-platform reimplementation of Notepad++"
HOMEPAGE="https://github.com/dail8859/NotepadNext"
SRC_URI="https://github.com/dail8859/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://api.github.com/repos/alex-spataru/QSimpleUpdater/tarball/${QSU_COMMIT} -> ${P}-qsu.tar.gz
	https://api.github.com/repos/githubuser0xFFFF/Qt-Advanced-Docking-System/tarball/${QADS_COMMIT} -> ${P}-qads.tar.gz
	https://api.github.com/repos/editorconfig/editorconfig-core-qt/tarball/${EC_COMMIT} -> ${P}-ec.tar.gz
	https://api.github.com/repos/itay-grudev/SingleApplication/tarball/${SA_COMMIT} -> ${P}-sa.tar.gz
	https://api.github.com/repos/freedesktop/uchardet/tarball/${UC_COMMIT} -> ${P}-uc.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtprintsupport:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5"

src_prepare() {
	default

	rmdir src/{QSimpleUpdater,ads,editorconfig-core-qt,singleapplication,uchardet} \
		|| die "rmdir failed for src"
	ln -s ../../alex-spataru-QSimpleUpdater-"${QSU_COMMIT}" src/QSimpleUpdater \
		|| die "ln failed for QSimpleUpdater"
	ln -s ../../githubuser0xFFFF-Qt-Advanced-Docking-System-"${QADS_COMMIT}" src/ads \
		|| die "ln failed for ads"
	ln -s ../../editorconfig-editorconfig-core-qt-"${EC_COMMIT}" src/editorconfig-core-qt \
		|| die "ln failed for editorconfig-core-qt"
	ln -s ../../itay-grudev-SingleApplication-"${SA_COMMIT}" src/singleapplication \
		|| die "ln failed for singleapplication"
	ln -s ../../freedesktop-uchardet-"${UC_COMMIT}" src/uchardet \
		|| die "ln failed for uchardet"
}

src_configure() {
	eqmake5 src/NotepadNext.pro
}

src_install() {
	einstalldocs
	emake INSTALL_ROOT="${ED}" install
}
