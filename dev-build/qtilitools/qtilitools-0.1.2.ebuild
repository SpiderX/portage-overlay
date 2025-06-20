# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Scripts/commands used in the Qtilities organization"
HOMEPAGE="https://github.com/qtilities/qtilitools"
SRC_URI="https://github.com/qtilities/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
