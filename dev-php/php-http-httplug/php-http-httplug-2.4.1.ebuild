# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Http/Client"
COMPOSER_VENDOR="php-http"
COMPOSER_PKG="${PN#${COMPOSER_VENDOR}-}"

inherit composer

DESCRIPTION="The HTTP client abstraction for PHP"
HOMEPAGE="https://github.com/php-http/httplug"
SRC_URI="https://github.com/php-http/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # no tests

RDEPEND="dev-php/php-http-promise
	dev-php/psr-http-client
	dev-php/psr-http-message"

DOCS=( {CHANGELOG,README}.md )
