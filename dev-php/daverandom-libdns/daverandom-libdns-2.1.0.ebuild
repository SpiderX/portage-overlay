# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="DaveRandom/LibDNS"
COMPOSER_PKG="LibDNS"
PHP_REQ_USE="ctype"

inherit composer

DESCRIPTION="DNS implementation in pure PHP"
HOMEPAGE="https://github.com/DaveRandom/LibDNS"
SRC_URI="https://github.com/DaveRandom/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test" # no tests for 2.x
