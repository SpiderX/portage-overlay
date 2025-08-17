# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 meson

DESCRIPTION="Qt wrapper around the D-Bus API from OpenRazer"
HOMEPAGE="https://github.com/z3ntu/libopenrazer"
EGIT_REPO_URI="https://github.com/wernerd/${PN^^}.git"

LICENSE="GPL-3"
SLOT="0"

RDEPEND="dev-qt/qtbase:6[dbus,xml]"
BDEPEND="virtual/pkgconfig"
