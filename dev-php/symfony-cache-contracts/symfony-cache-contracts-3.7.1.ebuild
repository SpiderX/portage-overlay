# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Symfony/Contracts/Cache"
COMPOSER_INSTALL_SRC="."

inherit composer

DESCRIPTION="Symfony Cache Contracts"
HOMEPAGE="https://github.com/symfony/cache-contracts"
SRC_URI="https://github.com/symfony/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test" # no tests

RDEPEND="dev-php/psr-cache"

DOCS=( {CHANGELOG,README}.md )
