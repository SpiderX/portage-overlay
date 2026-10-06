# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KFMIN=6.22.0

inherit ecm git-r3 readme.gentoo-r1

DESCRIPTION="Colored outline around any window that has the Keep Above property"
HOMEPAGE="https://github.com/Powermayer/keep-above-outline"
EGIT_REPO_URI="https://github.com/Powermayer/${PN}.git"

LICENSE="GPL-3+"
SLOT="0"

RDEPEND="dev-qt/qtbase:6[dbus,gui,widgets]
	kde-frameworks/kcmutils:6
	kde-frameworks/kconfig:6
	kde-frameworks/kcoreaddons:6
	kde-plasma/kwin:6"
DEPEND="${RDEPEND}"

DOC_CONTENTS="Enable the Keep Above Outline effect with:\\n
qdbus6 org.kde.KWin /Effects org.kde.kwin.Effects.loadEffect keep-above-outline\\n
Disable the Keep Above Outline effect with:\\n
qdbus6 org.kde.KWin /Effects org.kde.kwin.Effects.unloadEffect keep-above-outline\\n
Check whether the effect is loaded with:\\n
qdbus6 org.kde.KWin /Effects org.kde.kwin.Effects.isEffectLoaded keep-above-outline\\n
Alternatively, open System Settings -> Window Management -> Desktop Effects\\n
and enable or disable Keep Above Outline.\\n\\n"

src_install() {
	ecm_src_install
	readme.gentoo_create_doc
}

pkg_postinst() {
	readme.gentoo_print_elog
}
