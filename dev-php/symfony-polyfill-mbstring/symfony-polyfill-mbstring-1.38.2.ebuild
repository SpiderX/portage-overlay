# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Symfony/Polyfill/Mbstring"
COMPOSER_INSTALL_SRC="."
PHP_REQ_USE="iconv"

inherit composer

DESCRIPTION="Symfony polyfill for the Mbstring extension"
HOMEPAGE="https://github.com/symfony/polyfill-mbstring"
SRC_URI="https://github.com/symfony/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # no tests
