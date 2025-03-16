# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/Bali10050/${PN^}.git"

inherit ecm git-r3

DESCRIPTION="A modern style for qt applications"
HOMEPAGE="https://github.com/Bali10050/Darkly"

LICENSE="GPL-2"
SLOT="6"

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
	kde-plasma/kdecoration:6"
DEPEND="${RDEPEND}"
BDEPEND="kde-frameworks/kcmutils:6"

src_configure() {
	local mycmakeargs=(
		-DBUILD_QT6=ON
		-DBUILD_QT5=OFF
	)
	ecm_src_configure
}
