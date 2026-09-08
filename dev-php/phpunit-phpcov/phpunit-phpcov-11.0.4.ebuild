# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="SebastianBergmann/PHPCOV"
PHP_MIN_VER="8.3"

inherit composer

DESCRIPTION="TextUI frontend for php-code-coverage"
HOMEPAGE="https://github.com/sebastianbergmann/phpcov"
SRC_URI="https://github.com/sebastianbergmann/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="8.3"
KEYWORDS="~amd64"

RDEPEND="dev-php/phpunit
	dev-php/phpunit-php-code-coverage
	dev-php/phpunit-php-file-iterator
	dev-php/sebastian-cli-parser
	dev-php/sebastian-diff
	dev-php/sebastian-version"
BDEPEND="test? ( dev-php/xdebug )"

PATCHES=( "${FILESDIR}/${PN}"-9.0.2-autoload.patch )

DOCS=( {ChangeLog,README}.md )

COMPOSER_TEST_PATCHES=( "${FILESDIR}/${PN}"-11.0.4-tests.patch )
composer_enable_tests phpunit

src_test() {
	composer_prepare_tests
	# regenerate fixtures to change paths
	XDEBUG_MODE=coverage edo phpunit -c tests/fixture/example/phpunit.xml --filter '::testGreetsWorld$' \
		--coverage-php tests/fixture/example/coverage/testGreetsWorld.cov
	XDEBUG_MODE=coverage edo phpunit -c tests/fixture/example/phpunit.xml --filter '::testGreetsWithName$' \
		--coverage-php tests/fixture/example/coverage/testGreetsWithName.cov
	XDEBUG_MODE=coverage ephpunit
}

src_install() {
	composer_src_install

	exeinto /usr/share/php/"${COMPOSER_INSTALL_PATH}"
	doexe phpcov
	dosym ../share/php/"${COMPOSER_INSTALL_PATH}"/phpcov \
		/usr/bin/phpcov
}
