# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="SebastianBergmann/ObjectEnumerator"
PHP_MIN_VER="8.3"

inherit composer

DESCRIPTION="Traverses array structures and object graphs"
HOMEPAGE="https://github.com/sebastianbergmann/object-enumerator"
SRC_URI="https://github.com/sebastianbergmann/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-php/sebastian-object-reflector
	dev-php/sebastian-recursion-context"
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
