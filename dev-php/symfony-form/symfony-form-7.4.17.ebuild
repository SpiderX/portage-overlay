# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Symfony/Component/Form"
COMPOSER_INSTALL_SRC="."

inherit composer

DESCRIPTION="Symfony Form Component"
HOMEPAGE="https://github.com/symfony/form"
SRC_URI="https://github.com/symfony/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-php/symfony-deprecation-contracts
	dev-php/symfony-event-dispatcher
	dev-php/symfony-options-resolver
	dev-php/symfony-polyfill-ctype
	dev-php/symfony-polyfill-intl-icu
	dev-php/symfony-polyfill-mbstring
	dev-php/symfony-property-access
	dev-php/symfony-service-contracts"
BDEPEND="test? ( dev-php/doctrine-collections
		dev-php/symfony-clock
		dev-php/symfony-console
		dev-php/symfony-dependency-injection
		dev-php/symfony-expression-language
		dev-php/symfony-html-sanitizer
		dev-php/symfony-http-foundation
		dev-php/symfony-http-kernel
		dev-php/symfony-intl
		dev-php/symfony-phpunit-bridge
		dev-php/symfony-security-csrf
		dev-php/symfony-translation
		dev-php/symfony-validator
		dev-php/symfony-var-dumper
		dev-php/symfony-uid )"

DOCS=( {CHANGELOG,README}.md )

# exclude tests need fixture from other packages and locale-data dependent one
EPHPUNIT_EXCLUDE_FILTER='test(TypeExtensionClassIsTrackedAsResource|ArabicLocaleNonHtml5)'
composer_enable_tests phpunit

src_test() {
	composer_prepare_tests
	sed -i 's/ ignoreUndefinedTriggers="true"//' phpunit.xml.dist || die "sed failed for phpunit.xml.dist"
	# remove tests with class from validator tests
	edo rm Tests/Extension/Validator/Validator{Extension,TypeGuesser}Test.php
	ephpunit
}
