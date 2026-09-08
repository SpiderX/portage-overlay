# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="SebastianBergmann/Type"
PHP_MIN_VER="8.3"

inherit composer

DESCRIPTION="Library that helps with managing the version number"
HOMEPAGE="https://github.com/sebastianbergmann/type"
SRC_URI="https://github.com/sebastianbergmann/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="dev-php/theseer-Autoload"

DOCS=( {ChangeLog,README}.md )

EPHPUNIT_BOOTSTRAP='tests/autoload.php'
composer_enable_tests phpunit

src_prepare() {
	default

	edo phpab -q -o src/autoload.php -t "${FILESDIR}"/autoload.php.tpl src
}

src_test() {
	composer_prepare_tests
	edo phpab -q -o tests/autoload.php -t "${FILESDIR}"/autoload-test.php.tpl tests/_fixture
	ephpunit
}
