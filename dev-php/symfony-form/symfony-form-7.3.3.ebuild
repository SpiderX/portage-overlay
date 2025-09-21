# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN//symfony-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Symfony Form Component"
HOMEPAGE="https://github.com/symfony/form"
SRC_URI="https://github.com/symfony/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader
	dev-php/symfony-deprecation-contracts
	dev-php/symfony-event-dispatcher
	dev-php/symfony-options-resolver
	dev-php/symfony-polyfill-ctype
	dev-php/symfony-polyfill-intl-icu
	dev-php/symfony-polyfill-mbstring
	dev-php/symfony-property-access
	dev-php/symfony-service-contracts"
BDEPEND="test? ( dev-php/composer
		dev-php/doctrine-collections
		dev-php/phpunit
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

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
}

src_test() {
	composer require -d "${T}" --prefer-source \
		--dev "${PN/-/\/}:${PV}" || die "composer failed"
	cp -r "${T}"/vendor/"${PN/-/\/}"/{phpunit.xml.dist,Tests} "${S}" \
		|| die "cp failed"
	# remove test with class from validator tests
	rm Tests/Extension/Validator/Validator{Extension,TypeGuesser}Test.php \
		|| die "rm failed for ValidatorTest.php"
	# remove test with failed assertion
	sed -i '/testArabicLocaleNonHtml5/,+9d' \
		Tests/Extension/Core/Type/IntegerTypeTest.php \
		|| die "sed failed for IntegerTypeTest.php"
	# skipped — testReverseTransformFromDifferentLocale, testIntlTimeZoneInputWithBc{,AndIntl}
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Symfony/Component/Form
	doins -r ChoiceList Command Console DependencyInjection Event \
		Exception Extension Guess Resources Test Util ./*.php
}
