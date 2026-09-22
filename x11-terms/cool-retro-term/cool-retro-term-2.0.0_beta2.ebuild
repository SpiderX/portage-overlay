# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo qmake-utils xdg

SA_COMMIT="1848dd64e80e37326da4a22b2c1f45f2a1c4f231"
TW_COMMIT="8913504fa2ebd220ebe7c680c32954e1b3c035c5"

MY_PV="${PV/_/-}"

DESCRIPTION="A terminal emulator which mimics the old cathode display"
HOMEPAGE="https://github.com/Swordfish90/cool-retro-term"
SRC_URI="https://github.com/Swordfish90/${PN}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz
	https://github.com/KDAB/KDSingleApplication/archive/${SA_COMMIT}.tar.gz -> ${P}-sa.tar.gz
	https://github.com/Swordfish90/qmltermwidget/archive/${TW_COMMIT}.tar.gz -> ${P}-tw.tar.gz"
S="${WORKDIR}/${PN}-${MY_PV}"

LICENSE="GPL-2 GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-libs/qmltermwidget
	dev-qt/qtbase:6[gui,widgets]
	dev-qt/qtdeclarative:6"
DEPEND="${RDEPEND}"
BDEPEND="dev-qt/qtshadertools:6"

src_prepare() {
	default

	edo rmdir KDSingleApplication qmltermwidget
	edo ln -s ../KDSingleApplication-"${SA_COMMIT}" KDSingleApplication
	edo ln -s ../qmltermwidget-"${TW_COMMIT}" qmltermwidget

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
