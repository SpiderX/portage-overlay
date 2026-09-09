# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Symfony/Polyfill/Php85"
COMPOSER_INSTALL_SRC="."

inherit composer

DESCRIPTION="Backport of some PHP 8.5+ features to lower PHP versions"
HOMEPAGE="https://github.com/symfony/polyfill-php85"
SRC_URI="https://github.com/symfony/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # no tests
