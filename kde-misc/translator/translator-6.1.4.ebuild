# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit optfeature

MY_PN="org.kde.plasma.translator"

DESCRIPTION="Translator - KDE Plasma 6 Widget"
HOMEPAGE="https://github.com/rcspam/org.kde.plasma.translator"
SRC_URI="https://github.com/rcspam/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="MIT"
SLOT="6"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-qt/qt5compat:6
	dev-qt/qtdeclarative:6
	dev-qt/qtmultimedia:6
	kde-frameworks/kirigami:6
	kde-plasma/libplasma:6
	kde-plasma/plasma5support:6
	|| ( gui-apps/wl-clipboard x11-misc/xsel )"

src_install() {
	default

	insinto /usr/share/plasma/plasmoids/org.kde.plasma.translator
	doins -r contents metadata.json
}

pkg_postinst() {
	optfeature "translate-shell engines and text-to-speech support" app-i18n/translate-shell
}
