# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ecm

MY_PN="org.kde.plasma.translator"

DESCRIPTION="Translator - KDE Plasma 6 Widget"
HOMEPAGE="https://github.com/rcspam/org.kde.plasma.translator"
SRC_URI="https://github.com/rcspam/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="MIT"
SLOT="6"
KEYWORDS="~amd64 ~x86"

RDEPEND="app-i18n/translate-shell
	dev-qt/qt5compat:6
	dev-qt/qtmultimedia:6
	kde-frameworks/kdeclarative:6
	kde-frameworks/kirigami:6"

src_prepare() {
	default
}

src_configure() { :; }

src_compile() { :; }

src_install() {
	default

	insinto /usr/share/plasma/plasmoids/org.kde.plasma.translator
	doins -r contents metadata.json
}
