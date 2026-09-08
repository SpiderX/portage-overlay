# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="MabeEnum"
COMPOSER_VENDOR="marc-mabe"
COMPOSER_PKG="${PN#${COMPOSER_VENDOR}-}"

inherit composer

DESCRIPTION="Simple and fast implementation of enumerations with native PHP"
HOMEPAGE="https://github.com/marc-mabe/php-enum"
SRC_URI="https://github.com/marc-mabe/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

COMPOSER_TEST_PATCHES=(
	"${FILESDIR}/${PN}"-4.7.2-tests-EnumSetIteratorTest.patch
	"${FILESDIR}/${PN}"-4.7.2-tests-EnumSetTest.patch )
composer_enable_tests phpunit

src_test() {
	composer_prepare_tests
	edo php -d zend.assertions=1 /usr/bin/phpunit --testdox
}
