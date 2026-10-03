# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

PLOCALES="es_ES fr it nl pt_BR tr uk zh_CN"

inherit plocale

DESCRIPTION="Currently playing song and playback controls in Plasma 6"
HOMEPAGE="https://github.com/ccatterina/plasmusic-toolbar"
SRC_URI="https://github.com/ccatterina/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="6"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-qt/qt5compat:6
	dev-qt/qtdeclarative:6
	kde-frameworks/kcmutils:6
	kde-frameworks/kcoreaddons:6
	kde-frameworks/ki18n:6
	kde-frameworks/kiconthemes:6
	kde-frameworks/kirigami:6
	kde-frameworks/ksvg:6
	kde-plasma/libplasma:6
	kde-plasma/plasma-workspace:6"
BDEPEND="sys-devel/gettext"

src_prepare() {
	default

	my_rm_loc() {
		rm src/translate/"${1}".po || die "rm failed for ${1}"
	}
	plocale_for_each_disabled_locale my_rm_loc
}

src_compile() {
	edo bin/i18n compile
}

src_install() {
	default

	insinto /usr/share/plasma/plasmoids/plasmusic-toolbar
	doins -r src/{contents,metadata.json}
}
