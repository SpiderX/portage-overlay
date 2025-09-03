# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ecm git-r3

DESCRIPTION="A modern style for qt applications"
HOMEPAGE="https://github.com/Bali10050/Darkly"
EGIT_REPO_URI="https://github.com/Bali10050/${PN^}.git"

LICENSE="GPL-2"
SLOT="6"
IUSE="qt5"

RDEPEND="dev-qt/qtbase:6[dbus,gui,widgets]
	dev-qt/qtdeclarative:6
	kde-frameworks/frameworkintegration:6
	kde-frameworks/kcolorscheme:6
	kde-frameworks/kconfig:6
	kde-frameworks/kconfigwidgets:6
	kde-frameworks/kcoreaddons:6
	kde-frameworks/kguiaddons:6
	kde-frameworks/ki18n:6
	kde-frameworks/kirigami:6
	kde-frameworks/kiconthemes:6
	kde-frameworks/kwindowsystem:6
	kde-plasma/kdecoration:6
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtgui:5[dbus]
		dev-qt/qtwidgets:5
		dev-qt/qtdeclarative:5
		kde-frameworks/frameworkintegration:5
		kde-frameworks/kconfig:5
		kde-frameworks/kconfigwidgets:5
		kde-frameworks/kcoreaddons:5
		kde-frameworks/kguiaddons:5
		kde-frameworks/ki18n:5
		kde-frameworks/kirigami:5
		kde-frameworks/kiconthemes:5
		kde-frameworks/kwindowsystem:5
	)"
DEPEND="${RDEPEND}"
BDEPEND="kde-frameworks/kcmutils:6
	qt5? ( kde-frameworks/kcmutils:5 )"

src_configure() {
	local mycmakeargs=(
		-DBUILD_QT6=ON
		-DBUILD_QT5=$(usex qt5 ON OFF)
	)
	ecm_src_configure
}
