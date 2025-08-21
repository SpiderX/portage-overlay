# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ecm git-r3

DESCRIPTION="Spacer with Mouse gestures for the KDE Plasma Panel"
HOMEPAGE="https://github.com/luisbocanegra/plasma-panel-spacer-extended"
EGIT_REPO_URI="https://github.com/luisbocanegra/${PN}.git"

LICENSE="GPL-2+"
SLOT="0"

RDEPEND="kde-plasma/kdeplasma-addons:6
	kde-plasma/plasma-workspace:6"
