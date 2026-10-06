# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KFMIN=6.22.0

inherit ecm readme.gentoo-r1

DESCRIPTION="A smooth, customizable animated mouse cursor trail effect"
HOMEPAGE="https://github.com/wesleyyach/windtrail"
SRC_URI="https://github.com/wesleyyach/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-qt/qtbase:6[dbus,gui,widgets]
	kde-frameworks/kcmutils:6
	kde-frameworks/kconfig:6
	kde-frameworks/kcoreaddons:6
	kde-plasma/kwin:6
	media-libs/libepoxy"
DEPEND="${RDEPEND}"

DOCS=( {CHANGELOG,README}.md )
DOC_CONTENTS="Enable the WindTrail effect with:\\n
qdbus6 org.kde.KWin /Effects org.kde.kwin.Effects.loadEffect proxyx_windtrail\\n
Disable the WindTrail effect with:\\n
qdbus6 org.kde.KWin /Effects org.kde.kwin.Effects.unloadEffect proxyx_windtrail\\n
Check whether the effect is loaded with:\\n
qdbus6 org.kde.KWin /Effects org.kde.kwin.Effects.isEffectLoaded proxyx_windtrail\\n
Alternatively, open System Settings -> Window Management -> Desktop Effects\\n
and enable or disable WindTrail.\\n\\n"

src_install() {
	ecm_src_install
	readme.gentoo_create_doc
}

pkg_postinst() {
	readme.gentoo_print_elog
}
