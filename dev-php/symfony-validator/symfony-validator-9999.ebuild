# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Symfony Validator Component"
HOMEPAGE="https://github.com/symfony/validator"
EGIT_REPO_URI="https://github.com/symfony/validator.git"

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
BDEPEND="test? ( dev-php/egulias-email-validator
		dev-php/phpunit
		dev-php/symfony-config
		dev-php/symfony-console
		dev-php/symfony-dependency-injection
		dev-php/symfony-expression-language
		>=dev-php/symfony-finder-6
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
}

src_test() {
	# skipped 32
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Symfony/Component/Validator
	doins -r Attribute Command Constraints Context DataCollector \
		DependencyInjection Exception Mapping Resources \
		Test Util Validator Violation ./*.php
}
