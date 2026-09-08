# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Http/Discovery"
COMPOSER_VENDOR="php-http"
COMPOSER_PKG="${PN#${COMPOSER_VENDOR}-}"

inherit composer

DESCRIPTION="Finds installed clients and message factories"
HOMEPAGE="https://github.com/php-http/discovery"
SRC_URI="https://github.com/php-http/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # no tests

DOCS=( {CHANGELOG,README}.md )
