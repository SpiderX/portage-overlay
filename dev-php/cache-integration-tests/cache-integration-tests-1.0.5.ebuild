# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Cache/IntegrationTests"

inherit composer

DESCRIPTION="Integration tests for PSR-6 cache"
HOMEPAGE="https://github.com/php-cache/integration-tests"
SRC_URI="https://github.com/php-cache/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-php/cache-tag-interop
	dev-php/psr-cache
	dev-php/psr-simple-cache"
BDEPEND="test? ( dev-php/phpunit
		dev-php/symfony-cache )"

src_test() {
	ephpunit
}
