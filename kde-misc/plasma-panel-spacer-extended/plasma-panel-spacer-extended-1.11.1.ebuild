# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ecm

DESCRIPTION="Spacer with Mouse gestures for the KDE Plasma Panel"
HOMEPAGE="https://github.com/luisbocanegra/plasma-panel-spacer-extended"
SRC_URI="https://github.com/luisbocanegra/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="kde-plasma/kdeplasma-addons:6
	kde-plasma/plasma-workspace:6"
