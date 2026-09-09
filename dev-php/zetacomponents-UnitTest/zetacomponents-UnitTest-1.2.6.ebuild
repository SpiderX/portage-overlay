# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="ezc/UnitTest"

inherit composer

DESCRIPTION="Unit tests for any Zeta component"
HOMEPAGE="https://github.com/zetacomponents/UnitTest"
SRC_URI="https://github.com/zetacomponents/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # no tests
