# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KFMIN=6.22.0

inherit ecm readme.gentoo-r1

DESCRIPTION="KDE snow effect"
HOMEPAGE="https://github.com/joepadmiraal/kwin-snow"
SRC_URI="https://github.com/joepadmiraal/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-qt/qtbase:6[dbus,gui,widgets]
	kde-frameworks/kcmutils:6
	kde-frameworks/kconfig:6
	kde-frameworks/kconfigwidgets:6
	kde-frameworks/kcoreaddons:6
	kde-frameworks/ki18n:6
	kde-plasma/kwin:6"
DEPEND="${RDEPEND}
	dev-qt/qtdeclarative:6
	kde-frameworks/kwindowsystem:6"

DOC_CONTENTS="Enable the Snow effect with:\\n
qdbus6 org.kde.KWin /Effects org.kde.kwin.Effects.loadEffect snow\\n
Disable the Snow effect with:\\n
qdbus6 org.kde.KWin /Effects org.kde.kwin.Effects.unloadEffect snow\\n
Check whether the effect is loaded with:\\n
qdbus6 org.kde.KWin /Effects org.kde.kwin.Effects.isEffectLoaded snow\\n
Alternatively, open System Settings -> Window Management -> Desktop Effects\\n
and enable or disable Snow in the Appearance category.\\n\\n"

src_configure() {
	local mycmakeargs=(
		-DSNOW_QT_PLUGIN_DIR="/usr/$(get_libdir)/qt6/plugins"
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
