# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="staabm/SideEffectsDetector"
COMPOSER_INSTALL_SRC="lib"
PHP_REQ_USE="tokenizer"

inherit composer

DESCRIPTION="Analyzes php-code for side-effects"
HOMEPAGE="https://github.com/staabm/side-effects-detector"
SRC_URI="https://github.com/staabm/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="dev-php/theseer-Autoload"

EPHPUNIT_BOOTSTRAP='tests/autoload.php'
COMPOSER_TEST_PATCHES=( "${FILESDIR}/${PN}"-1.0.5-tests.patch )
composer_enable_tests phpunit

src_prepare() {
	default

	edo phpab -q -o lib/autoload.php -t "${FILESDIR}"/autoload.php.tpl lib
}

src_test() {
	composer_prepare_tests
	edo phpab -q -o tests/autoload.php -t "${FILESDIR}"/autoload-test.php.tpl tests
	ephpunit
}
