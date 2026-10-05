# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KFMIN=6.22.0

inherit ecm git-r3

DESCRIPTION="KDE snow effect"
HOMEPAGE="https://github.com/joepadmiraal/kwin-snow"
EGIT_REPO_URI="https://github.com/joepadmiraal/${PN}.git"

LICENSE="GPL-2"
SLOT="0"

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
