# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

PLOCALES="bg cs_CZ de es fr hu_HU it_IT ja_JP ko_KR nl pl_PL pt_BR ru sv_SE tr_TR uk zh_CN zh_TW"

inherit optfeature plocale

DESCRIPTION="Advanced Weather Widget for KDE Plasma 6"
HOMEPAGE="https://github.com/pnedyalkov91/advanced-weather-widget"
SRC_URI="https://github.com/pnedyalkov91/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-qt/qt5compat:6
	dev-qt/qtdeclarative:6
	dev-qt/qtmultimedia:6
	dev-qt/qtpositioning:6
	dev-qt/qttools:6
	kde-frameworks/kiconthemes:6
	kde-frameworks/kirigami:6
	kde-frameworks/knotifications:6
	kde-plasma/libplasma:6
	kde-plasma/plasma5support:6"

src_prepare() {
	default

	my_rm_loc() {
		rm -r contents/locale/"${1}" || die "rm failed for ${1}"
	}
	plocale_for_each_disabled_locale my_rm_loc
}

src_install() {
	default

	insinto /usr/share/plasma/plasmoids/org.kde.plasma.advanced-weather-widget
	doins -r {contents,metadata.json}
}

pkg_postinst() {
	optfeature "interactive Radar tab" dev-qt/qtwebengine
}
