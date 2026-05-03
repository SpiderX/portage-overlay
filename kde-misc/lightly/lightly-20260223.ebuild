# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ecm

COMMIT="459d7d1c65883e224f6bc384613b240515e67727"

DESCRIPTION="KDE theme style with aim to be visually modern and minimalistic"
HOMEPAGE="https://github.com/xuzhao9/Lightly"
SRC_URI="https://github.com/xuzhao9/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN^}-${COMMIT}"

LICENSE="GPL-2"
SLOT="6"
KEYWORDS="~amd64 ~x86"

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
