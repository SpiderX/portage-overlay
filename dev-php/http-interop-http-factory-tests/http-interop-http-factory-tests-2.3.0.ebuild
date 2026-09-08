# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Interop/Http/Factory"
COMPOSER_INSTALL_SRC="test"
COMPOSER_VENDOR="http-interop"
COMPOSER_PKG="${PN#${COMPOSER_VENDOR}-}"

inherit composer

DESCRIPTION="Unit tests for HTTP Factory implementations"
HOMEPAGE="https://github.com/http-interop/http-factory-tests"
SRC_URI="https://github.com/http-interop/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test" # no tests

RDEPEND="dev-php/phpunit
	dev-php/psr-http-factory"
