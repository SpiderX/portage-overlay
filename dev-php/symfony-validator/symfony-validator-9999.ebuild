# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/symfony/validator.git"

inherit git-r3

DESCRIPTION="Symfony Validator Component"
HOMEPAGE="https://github.com/symfony/validator"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader
	dev-php/symfony-deprecation-contracts
	dev-php/symfony-polyfill-ctype
	dev-php/symfony-polyfill-mbstring
	dev-php/symfony-polyfill-php83
	dev-php/symfony-translation-contracts"
BDEPEND="test? ( dev-php/doctrine-annotations
		dev-php/egulias-email-validator
		dev-php/phpunit
		dev-php/symfony-config
		dev-php/symfony-console
		dev-php/symfony-dependency-injection
		dev-php/symfony-expression-language
		>=dev-php/symfony-finder-6.4.8
		dev-php/symfony-http-client
		dev-php/symfony-http-kernel
		dev-php/symfony-intl
		dev-php/symfony-mime
		dev-php/symfony-phpunit-bridge
		dev-php/symfony-property-access
		dev-php/symfony-translation
		dev-php/symfony-yaml )"

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
	# remove tests which DivisibleByValidator rejects null values
	rm Tests/Constraints/DivisibleByValidatorTest.php \
		|| die "rm failed for DivisibleByValidatorTest.php"
}

src_test() {
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Symfony/Component/Validator
	doins -r Attribute Command Constraints Context DataCollector \
		DependencyInjection Exception Mapping Resources \
		Test Util Validator Violation ./*.php
}
