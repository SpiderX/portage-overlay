# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Http/Psr7Test"
COMPOSER_VENDOR="php-http"
COMPOSER_PKG="${PN#${COMPOSER_VENDOR}-}"

inherit composer

DESCRIPTION="A PSR-7 implementation tests"
HOMEPAGE="https://github.com/php-http/psr7-integration-tests"
SRC_URI="https://github.com/php-http/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test" # needs tests from other packages

RDEPEND="dev-php/phpunit
	dev-php/psr-http-message"

DOCS=( {CHANGELOG,README}.md )
