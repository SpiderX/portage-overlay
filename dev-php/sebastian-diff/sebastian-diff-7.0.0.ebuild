# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="SebastianBergmann/Diff"
PHP_MIN_VER="8.3"

inherit composer

DESCRIPTION="PHP Diff implementation"
HOMEPAGE="https://github.com/sebastianbergmann/diff"
SRC_URI="https://github.com/sebastianbergmann/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="dev-php/theseer-Autoload"

DOCS=( {ChangeLog,README}.md )

COMPOSER_TEST_PATCHES=( "${FILESDIR}/${PN}"-7.0.0-tests.patch )
EPHPUNIT_BOOTSTRAP='vendor/autoload.php'
composer_enable_tests phpunit

src_prepare() {
	composer_src_prepare

	edo phpab -q -o src/autoload.php -t fedora2 src
}

src_test() {
	composer_prepare_tests
	edo phpab -q -o tests/autoload.php -t fedora2 tests
	ephpunit
}
