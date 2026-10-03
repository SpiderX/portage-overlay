# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 optfeature qt-utils virtualx

DESCRIPTION="Translator - KDE Plasma 6 Widget"
HOMEPAGE="https://github.com/rcspam/org.kde.plasma.translator"
EGIT_REPO_URI="https://github.com/rcspam/org.kde.plasma.translator.git"

LICENSE="MIT"
SLOT="6"

RDEPEND="dev-qt/qt5compat:6
	dev-qt/qtdeclarative:6
	dev-qt/qtmultimedia:6
	kde-frameworks/kirigami:6
	kde-plasma/libplasma:6
	kde-plasma/plasma5support:6
	|| ( gui-apps/wl-clipboard x11-misc/xsel )"

src_test() {
	virtx "$(qt_get_broot_binary 6 qmltestrunner)" -input tests
}

src_install() {
	default

	insinto /usr/share/plasma/plasmoids/org.kde.plasma.translator
	doins -r contents metadata.json
}

pkg_postinst() {
	optfeature "translate-shell engines and text-to-speech support" app-i18n/translate-shell
}
