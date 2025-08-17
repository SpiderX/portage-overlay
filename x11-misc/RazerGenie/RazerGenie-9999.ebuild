# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 meson

DESCRIPTION="Razer devices configurator"
HOMEPAGE="https://github.com/z3ntu/RazerGenie"
EGIT_REPO_URI="https://github.com/z3ntu/${PN}.git"

LICENSE="GPL-3"
SLOT="0"

RDEPEND="dev-libs/libopenrazer
	dev-qt/qtbase:6[dbus,network,widgets]"
BDEPEND="dev-qt/qttools:6[linguist]
	virtual/pkgconfig"
