# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo git-r3 qmake-utils xdg

DESCRIPTION="A terminal emulator which mimics the old cathode display"
HOMEPAGE="https://github.com/Swordfish90/cool-retro-term"
EGIT_REPO_URI="https://github.com/Swordfish90/${PN}.git"

LICENSE="GPL-2 GPL-3"
SLOT="0"

RDEPEND="dev-libs/qmltermwidget
	dev-qt/qtbase:6[gui,widgets]
	dev-qt/qtdeclarative:6"
DEPEND="${RDEPEND}"
BDEPEND="dev-qt/qtshadertools:6"

src_prepare() {
	default

	# do not install bundled qmltermwidget
	sed -i '/INSTALLS/d' qmltermwidget/qmltermwidget.pro \
		|| die "sed failed for qmltermwidget"
}

src_configure() {
	eqmake6 PREFIX="${EPREFIX}/usr"
}

src_install() {
	emake INSTALL_ROOT="${ED}" install
	doman packaging/debian/cool-retro-term.1
	insinto /usr/share/metainfo
	doins packaging/appdata/cool-retro-term.appdata.xml
}
