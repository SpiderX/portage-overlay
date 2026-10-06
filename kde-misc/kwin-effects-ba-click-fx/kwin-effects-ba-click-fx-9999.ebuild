# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KFMIN=6.22.0

inherit ecm git-r3 readme.gentoo-r1

DESCRIPTION="Blue Archive Unity click effect and cursor trail for KDE Plasma"
HOMEPAGE="https://github.com/floating142/kwin-effects-ba-click-fx"
EGIT_REPO_URI="https://github.com/floating142/${PN}.git"

LICENSE="GPL-3+"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-qt/qtbase:6[dbus,gui,widgets]
	kde-frameworks/kcmutils:6
	kde-frameworks/kconfig:6
	kde-frameworks/kcoreaddons:6
	kde-frameworks/ki18n:6
	kde-frameworks/kservice:6
	kde-plasma/kwin:6"
DEPEND="${RDEPEND}
	dev-qt/qtdeclarative:6
	kde-frameworks/kwindowsystem:6
	test? ( dev-qt/qtbase:6[test] )"

DOC_CONTENTS="Enable the BA Click FX effect with:\\n
qdbus6 org.kde.KWin /Effects org.kde.kwin.Effects.loadEffect kwin4_effect_ba_click_fx\\n
Disable the BA Click FX effect with:\\n
qdbus6 org.kde.KWin /Effects org.kde.kwin.Effects.unloadEffect kwin4_effect_ba_click_fx\\n
Check whether the effect is loaded with:\\n
qdbus6 org.kde.KWin /Effects org.kde.kwin.Effects.isEffectLoaded kwin4_effect_ba_click_fx\\n
Alternatively, open System Settings -> Window Management -> Desktop Effects\\n
and enable or disable BA Click FX.\\n\\n"

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING="$(usex test)"
	)

	ecm_src_configure
}

src_install() {
	ecm_src_install
	readme.gentoo_create_doc
}

pkg_postinst() {
	readme.gentoo_print_elog
}
