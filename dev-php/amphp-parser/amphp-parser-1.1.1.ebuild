# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Amp/Parser"

inherit composer

DESCRIPTION="A generator parser to make streaming parsers simple"
HOMEPAGE="https://github.com/amphp/parser"
SRC_URI="https://github.com/amphp/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

composer_enable_tests phpunit
