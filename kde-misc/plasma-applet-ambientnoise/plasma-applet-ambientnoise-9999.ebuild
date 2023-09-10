# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/m-pilia/${PN}.git"

inherit ecm git-r3

COMMIT="ccbe62f58b72931008a7b26c3e8ab92e2bc3a52c"

DESCRIPTION="Plasma 5 widget for play ambient noise"
HOMEPAGE="https://github.com//plasma-applet-ambientnoise"
SRC_URI=""

LICENSE="GPL-3"
SLOT="5"
KEYWORDS=""

RDEPEND="dev-qt/qtquickcontrols2:5
	kde-frameworks/plasma:5"
