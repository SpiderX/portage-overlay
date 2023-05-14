# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://gitlab.com/flaviotordini/${PN}.git"

inherit git-r3 qmake-utils xdg

DESCRIPTION="A finely crafted music player"
HOMEPAGE="https://github.com/flaviotordini/musique"
SRC_URI=""

LICENSE="GPL-3 MIT"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtsingleapplication[qt5(+),X]
	dev-qt/qtsql:5[sqlite]
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	media-libs/taglib
	media-video/mpv[libmpv]"
DEPEND="${RDEPEND}"
BDEPEND="dev-qt/linguist-tools:5"

src_prepare() {
	default

	# use system qtsingleapplication
	sed -i  -e '/CONFIG += /s/rtti_off/rtti_off qtsingleapplication/' \
		-e '/qtsingleapplication.pri/d' \
		musique.pro || die "sed failed for musique.pro"
}

src_configure() {
	eqmake5 musique.pro PREFIX="/usr"
}

src_install() {
	einstalldocs
	emake INSTALL_ROOT="${D}" install
}
