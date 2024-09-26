# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/luisbocanegra/${PN}.git"

inherit ecm git-r3

DESCRIPTION="Spacer with Mouse gestures for the KDE Plasma Panel"
HOMEPAGE="https://github.com/luisbocanegra/plasma-panel-spacer-extended"

LICENSE="GPL-2+"
SLOT="0"
IUSE="plugin"

RDEPEND="kde-plasma/kdeplasma-addons:6
	kde-plasma/plasma-workspace:6
	plugin? ( dev-qt/qtcore:5
		dev-qt/qtdeclarative:5
		dev-qt/qtgui:5
		dev-qt/qtquickcontrols:5
		kde-frameworks/ki18n:5
		kde-plasma/libplasma:5 )"
BDEPEND="kde-frameworks/extra-cmake-modules"

src_configure() {
	local mycmakeargs=(
		-DBUILD_PLUGIN="$(usex plugin ON OFF)"
	)
	cmake_src_configure
}
