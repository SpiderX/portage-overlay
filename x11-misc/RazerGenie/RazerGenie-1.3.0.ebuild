# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Razer devices configurator"
HOMEPAGE="https://github.com/z3ntu/RazerGenie"
SRC_URI="https://github.com/z3ntu/RazerGenie/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-libs/libopenrazer
	dev-qt/qtbase:6[dbus,network,widgets]"
BDEPEND="dev-qt/qttools:6[linguist]
	virtual/pkgconfig"
