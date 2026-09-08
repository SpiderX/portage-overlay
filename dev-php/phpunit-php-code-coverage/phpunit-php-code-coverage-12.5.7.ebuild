# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMPOSER_INSTALL_PATH="SebastianBergmann/CodeCoverage"
PHP_MIN_VER="8.3"
PHP_REQ_USE="xml,xmlwriter"

inherit composer edo optfeature

DESCRIPTION="Library for PHP code coverage information"
HOMEPAGE="https://github.com/sebastianbergmann/php-code-coverage"
SRC_URI="https://github.com/sebastianbergmann/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="8.3"
KEYWORDS="~amd64"

RDEPEND=">=dev-php/nikic-php-parser-5.7.0
	dev-php/phpunit-php-text-template
	dev-php/sebastian-complexity
	dev-php/sebastian-environment
	dev-php/sebastian-lines-of-code
	dev-php/sebastian-version
	dev-php/theseer-tokenizer"
BDEPEND="dev-php/theseer-Autoload"

# PHPUnit preloads installed php-code-coverage before package bootstrap,
# so this path-sensitive self-test sees /usr/share/php instead of ${S}/src
EPHPUNIT_EXCLUDE_FILTER='testCanBeCreatedFromDefaults'
composer_enable_tests phpunit

src_prepare() {
	default

	edo phpab -q -o src/autoload.php -t "${FILESDIR}"/autoload.php.tpl src
}

src_test() {
	composer_prepare_tests
	edo mkdir vendor
	edo phpab -q -o vendor/autoload.php -t "${FILESDIR}"/autoload-test.php.tpl tests/src
	ephpunit
}

pkg_postinst() {
	optfeature "support line coverage" dev-php/phpunit-phpcov
	optfeature "line coverage as well as branch and path coverage" dev-php/xdebug
}
