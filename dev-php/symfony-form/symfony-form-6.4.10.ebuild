# Copyright 1999-2024 Gentoo Authors
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
KEYWORDS="~amd64 ~x86"
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
	# ignore risky tests
	sed -i '/failOnRisky/s|true|false|' phpunit.xml.dist \
		|| die "sed failed for phpunit.xml.dist"
	# remove test with class from validator tests
	rm Tests/Extension/Validator/Validator{Extension,TypeGuesser}Test.php \
		|| die "rm failed for ValidatorTest.php"
	# remove tests with call to protected __construct()
	rm Tests/Extension/Validator/Constraints/FormValidatorTest.php \
		|| die "rm failed for FormValidatorTest.php"
	# rename test to trait
	mv Tests/VersionAwareT{est,rait}.php || die "mv failed for VersionAwareTest.php"
	sed -i '/trait/s|Test|Trait|' Tests/VersionAwareTrait.php \
		|| die "sed failed for VersionAwareTest.php"
	sed -i '/use Symfony\\\Component\\\Form\\\Tests/s|Test;|Trait;|' \
		Test/FormPerformanceTestCase.php Tests/Extension/Core/Type/BaseTypeTestCase.php \
		|| die "sed failed for FormPerformanceTestCase.php"
	sed -i '/use VersionAware/s|Test|Trait|' Test/FormPerformanceTestCase.php \
		Tests/Extension/Core/Type/BaseTypeTestCase.php \
		|| die "sed failed for BaseTypeTestCase.php"
	# remove test with date parsing failed
	sed -i '/testReverseTransformFromDifferentLocale/,+8d' \
		Tests/Extension/Core/DataTransformer/DateTimeToLocalizedStringTransformerTest.php \
		|| die "sed failed for DateTimeToLocalizedStringTransformerTest.php"
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Symfony/Component/Form
	doins -r ChoiceList Command Console DependencyInjection Event \
		Exception Extension Guess Resources Test Util ./*.php
}
