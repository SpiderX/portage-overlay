# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KDE_ORG_COMMIT="394ef5e06c21a706cab9a2c34b6d81460aa74d07"
PLOCALES="ar ast az bg ca ca@valencia cs da de el en_GB eo es et eu fi fr gl he hi hu ia it ja ka ko lt lv nl nn pa pl pt pt_BR ro ru sa sk sl sv ta tr uk vi zh_CN zh_TW"
PLOCALE_BACKUP="en"

inherit ecm kde.org plocale

DESCRIPTION="Plasma applet to access password from pass"
HOMEPAGE="https://www.dvratil.cz/2018/05/plasma-pass/ https://invent.kde.org/plasma/plasma-pass"

LICENSE="LGPL-2.1+"
SLOT="6"

DEPEND="app-crypt/gpgme:=[cxx,qt6]
	dev-qt/qt5compat:6[qml]
	dev-qt/qtbase:6[concurrent,dbus,gui]
	dev-qt/qtdeclarative:6
	kde-frameworks/kcoreaddons:6
	kde-frameworks/ki18n:6
	kde-frameworks/kio:6
	kde-frameworks/kitemmodels:6
	kde-plasma/libplasma:6
	kde-plasma/plasma5support:6
	sys-auth/oath-toolkit"
RDEPEND="${DEPEND}
	kde-frameworks/kirigami:6"

src_prepare() {
	my_rm_loc() {
		rm -rf po/"${1}" || die "rm failed for ${1}"
	}
	plocale_for_each_disabled_locale my_rm_loc

	cmake_src_prepare
}
