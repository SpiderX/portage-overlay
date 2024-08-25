# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PLOCALES="ar ast az ca ca@valencia cs da de el en_GB es et eu fi fr gl hsb ia id it ja ko lt nl nn pl pt pt_BR ro ru sk sl sv tr uk zh_CN zh_TW"
PLOCALE_BACKUP="en"

inherit ecm kde.org plocale

DESCRIPTION="Elegant dock, based on KDE Frameworks"
HOMEPAGE="https://apps.kde.org/latte-dock/"
SRC_URI="mirror://kde/stable/${PN}/${P}.tar.xz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

COMMON_DEPEND="dev-libs/wayland
	dev-qt/qtdbus:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgraphicaleffects:5
	dev-qt/qtgui:5[X]
	dev-qt/qtwayland:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	kde-frameworks/karchive:5
	kde-frameworks/kconfig:5
	kde-frameworks/kcoreaddons:5
	kde-frameworks/kcrash:5
	kde-frameworks/kdbusaddons:5
	kde-frameworks/kdeclarative:5
	kde-frameworks/kglobalaccel:5
	kde-frameworks/kguiaddons:5
	kde-frameworks/ki18n:5
	kde-frameworks/kiconthemes:5
	kde-frameworks/kio:5
	kde-frameworks/kirigami:5
	kde-frameworks/knewstuff:5
	kde-frameworks/knotifications:5
	kde-frameworks/kpackage:5
	kde-plasma/kwayland:5
	kde-frameworks/kwindowsystem:5
	kde-frameworks/kxmlgui:5
	kde-plasma/libplasma:5[X(+)]
	kde-plasma/plasma-activities:5
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/xcb-util"
DEPEND="${COMMON_DEPEND}
	dev-libs/plasma-wayland-protocols"
RDEPEND="${COMMON_DEPEND}
	dev-qt/qtquickcontrols:5
	dev-qt/qtquickcontrols2:5"
BDEPEND="dev-qt/qtwaylandscanner:5
	dev-util/wayland-scanner"

PATCHES=( "${FILESDIR}/${PN}-0.10.1-dont-hide-warnings.patch" )

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	my_rm_loc() {
		rm -rf po/"${1}" || die "rm failed for po/${1}"
	}
	plocale_for_each_disabled_locale my_rm_loc

	ecm_src_prepare
}
