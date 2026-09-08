# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="MabeEnum"
COMPOSER_VENDOR="marc-mabe"
COMPOSER_PKG="${PN#${COMPOSER_VENDOR}-}"

inherit composer git-r3

DESCRIPTION="Simple and fast implementation of enumerations with native PHP"
HOMEPAGE="https://github.com/marc-mabe/php-enum"
EGIT_REPO_URI="https://github.com/marc-mabe/php-enum.git"

LICENSE="BSD"
SLOT="0"

PATCHES=( "${FILESDIR}/${PN}"-4.7.2-tests-EnumSetIteratorTest.patch
	"${FILESDIR}/${PN}"-4.7.2-tests-EnumSetTest.patch )

composer_enable_tests phpunit

src_test() {
	edo php -d zend.assertions=1 /usr/bin/phpunit --testdox
}
