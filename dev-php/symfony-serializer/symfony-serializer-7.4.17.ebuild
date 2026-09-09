# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Symfony/Component/Serializer"
COMPOSER_INSTALL_SRC="."
PHP_REQ_USE="bcmath?,gmp?"

inherit composer

DESCRIPTION="Symfony Serializer Component"
HOMEPAGE="https://github.com/symfony/serializer"
SRC_URI="https://github.com/symfony/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="bcmath gmp"
REQUIRED_USE="test? ( bcmath gmp )"

RDEPEND="dev-php/symfony-deprecation-contracts
	dev-php/symfony-polyfill-ctype
	dev-php/symfony-polyfill-php84"
BDEPEND="test? ( dev-php/jsonlint
		dev-php/phpdocumentor-reflection-docblock
		dev-php/phpstan-phpdoc-parser
		dev-php/symfony-cache
		dev-php/symfony-config
		dev-php/symfony-console
		dev-php/symfony-dependency-injection
		dev-php/symfony-error-handler
		>=dev-php/symfony-filesystem-7
		dev-php/symfony-http-foundation
		dev-php/symfony-http-kernel
		dev-php/symfony-form
		dev-php/symfony-messenger
		dev-php/symfony-mime
		dev-php/symfony-phpunit-bridge
		dev-php/symfony-property-access
		dev-php/symfony-property-info
		dev-php/symfony-translation-contracts
		dev-php/symfony-type-info
		dev-php/symfony-uid
		dev-php/symfony-validator
		dev-php/symfony-var-dumper
		dev-php/symfony-var-exporter
		dev-php/symfony-yaml )"

DOCS=( {CHANGELOG,README}.md )

# skip test depends on PHP/libxml behavior
EPHPUNIT_EXCLUDE_FILTER='testEncodeException'
COMPOSER_TEST_PATCHES=( "${FILESDIR}/${PN}"-7.4.17-tests.patch )
composer_enable_tests phpunit
