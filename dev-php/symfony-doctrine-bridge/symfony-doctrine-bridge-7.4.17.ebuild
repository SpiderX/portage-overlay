# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Symfony/Bridge/Doctrine"
COMPOSER_INSTALL_SRC="."

inherit composer

DESCRIPTION="Symfony Doctrine Bridge"
HOMEPAGE="https://github.com/symfony/doctrine-bridge"
SRC_URI="https://github.com/symfony/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-php/doctrine-event-manager
	dev-php/doctrine-persistence
	dev-php/symfony-deprecation-contracts
	dev-php/symfony-polyfill-ctype
	dev-php/symfony-polyfill-mbstring
	dev-php/symfony-service-contracts"
BDEPEND="test? ( dev-php/doctrine-collections
		dev-php/doctrine-data-fixtures
		dev-php/doctrine-dbal
		dev-php/doctrine-orm
		dev-php/psr-log
		dev-php/symfony-cache
		dev-php/symfony-config
		dev-php/symfony-dependency-injection
		dev-php/symfony-doctrine-messenger
		dev-php/symfony-expression-language
		dev-php/symfony-form
		dev-php/symfony-http-kernel
		dev-php/symfony-lock
		dev-php/symfony-messenger
		dev-php/symfony-phpunit-bridge
		dev-php/symfony-property-access
		dev-php/symfony-property-info
		dev-php/symfony-security-core
		dev-php/symfony-stopwatch
		dev-php/symfony-translation
		dev-php/symfony-type-info
		dev-php/symfony-validator
		dev-php/symfony-var-dumper
		dev-php/symfony-uid )"

DOCS=( {CHANGELOG,README}.md )

COMPOSER_TEST_PATCHES=( "${FILESDIR}/${PN}"-7.4.17-tests-MiddlewareTest.patch )
composer_enable_tests phpunit

src_test() {
	composer_prepare_tests
	sed -i 's/ ignoreUndefinedTriggers="true"//' phpunit.xml.dist || die "sed failed for phpunit.xml.dist"
	# remove tests require classes from tests for another package
	edo rm Tests/Form/Type/EntityTypeTest.php
	ephpunit
}
