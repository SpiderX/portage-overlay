# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Laminas/Diactoros"
COMPOSER_PKG="${PN}"
PHP_REQ_USE="curl?,gd?,ipv6?,xml?"

inherit composer

DESCRIPTION="PSR HTTP Message implementations"
HOMEPAGE="https://github.com/laminas/laminas-diactoros"
SRC_URI="https://github.com/laminas/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="curl gd ipv6 xml"
REQUIRED_USE="test? ( curl gd xml )"

RDEPEND="dev-php/psr-http-factory
	dev-php/psr-http-message"
BDEPEND="test? ( dev-php/http-interop-http-factory-tests
		dev-php/php-http-psr7-integration-tests )"

PATCHES=( "${FILESDIR}/${PN}"-3.8.0-src-Stream.patch )

composer_enable_tests phpunit

src_test() {
	use ipv6 || COMPOSER_TEST_PATCHES+=( "${FILESDIR}/${PN}"-3.8.0-tests-no-ipv6.patch )
	composer_prepare_tests
	edo mkdir -p vendor/http-interop/http-factory-tests
	edo ln -s ../../../../../../../../../../usr/share/php/Interop/Http/Factory/ \
		vendor/http-interop/http-factory-tests/test
	ephpunit
}
