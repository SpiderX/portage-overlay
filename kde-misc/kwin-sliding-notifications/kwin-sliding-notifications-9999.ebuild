# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ecm git-r3 optfeature readme.gentoo-r1

DESCRIPTION="Plasma 6 Sliding animation for notification windows"
HOMEPAGE="https://github.com/RussH/kwin-sliding-notifications"
EGIT_REPO_URI="https://github.com/RussH/${PN}.git"

LICENSE="MIT"
SLOT="6"

DEPEND="dev-qt/qtbase:6[gui]
	kde-frameworks/kconfig:6
	kde-frameworks/kcoreaddons:6
	kde-frameworks/kwidgetsaddons:6
	kde-frameworks/kwindowsystem:6"
RDEPEND="${DEPEND}
	kde-plasma/kwin:6"

DOC_CONTENTS="Enable the plugin and without restarting session:\\n
kwriteconfig6 --file kwinrc --group Plugins --key kwin_final_slidingEnabled true\\n"

src_install() {
	cmake_src_install
	readme.gentoo_create_doc
}

pkg_postinst() {
	optfeature "Support of notification sound via PipeWire" media-video/pipewire[extra]
	readme.gentoo_print_elog
}
