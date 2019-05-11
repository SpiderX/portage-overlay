# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/z3ntu/${PN}.git"

inherit git-r3 meson

DESCRIPTION="Razer devices configurator"
HOMEPAGE="https://github.com/z3ntu/RazerGenie"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="experimental matrix"

DEPEND="dev-qt/qtdbus:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5"
RDEPEND="${DEPEND}
	x11-misc/openrazer[daemon]"
BDEPEND="dev-qt/linguist-tools:5
	virtual/pkgconfig"

src_configure() {
	local emesonargs=(
		"$(meson_use experimental enable_experimental)"
		"$(meson_use matrix include_matrix_discovery)"
	)
	meson_src_configure
}
