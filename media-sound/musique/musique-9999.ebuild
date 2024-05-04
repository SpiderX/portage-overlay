# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://gitlab.com/flaviotordini/${PN}.git"

inherit git-r3 qmake-utils xdg

DESCRIPTION="A finely crafted music player"
HOMEPAGE="https://github.com/flaviotordini/musique"

LICENSE="GPL-3 MIT"
SLOT="0"

RDEPEND="dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtsql:5[sqlite]
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	media-libs/taglib
	media-video/mpv[libmpv]"
DEPEND="${RDEPEND}"
BDEPEND="dev-qt/linguist-tools:5"

src_prepare() {
	default

	# don't use lrelease from path
	# https://github.com/flaviotordini/musique/commit/05bf89e143728a0e1c1be496d761d80d4a8469f8
	sed -i '/else:QMAKE_LRELEASE/s|= |= $$[QT_INSTALL_BINS]/|' locale/locale.pri \
		|| die "sed failed for locale.pri"
}

src_configure() {
	eqmake6 musique.pro PREFIX="/usr"
}

src_install() {
	einstalldocs
	emake INSTALL_ROOT="${D}" install
}
