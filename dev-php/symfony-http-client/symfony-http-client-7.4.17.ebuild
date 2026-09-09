# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Symfony/Component/HttpClient"
COMPOSER_INSTALL_SRC="."

inherit composer

DESCRIPTION="Symfony HttpClient Component"
HOMEPAGE="https://github.com/symfony/http-client"
SRC_URI="https://github.com/symfony/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="ipv6"

RDEPEND="dev-php/psr-log
	dev-php/symfony-deprecation-contracts
	dev-php/symfony-http-client-contracts
	dev-php/symfony-polyfill-php83
	dev-php/symfony-service-contracts"
BDEPEND="test? ( dev-php/amphp-http-client
		dev-php/doctrine-deprecations
		dev-php/guzzlehttp-promises
		dev-php/nyholm-psr7
		dev-php/php-http-httplug
		dev-php/psr-http-client
		dev-php/symfony-cache
		dev-php/symfony-dependency-injection
		dev-php/symfony-http-kernel
		dev-php/symfony-messenger
		dev-php/symfony-phpunit-bridge
		>=dev-php/symfony-process-7
		dev-php/symfony-rate-limiter
		dev-php/symfony-stopwatch )"

DOCS=( {CHANGELOG,README}.md )

composer_enable_tests phpunit

src_test() {
	use ipv6 || COMPOSER_TEST_PATCHES=( "${FILESDIR}/${PN}"-7.3.3-test-no-ipv6.patch )
	composer_prepare_tests
	sed -i 's/ ignoreUndefinedTriggers="true"//' phpunit.xml.dist || die "sed failed for phpunit.xml.dist"
	# dev-php/amphp-http-client-5 requires php 8.4
	has_version ">=dev-lang/php-8.4" || edo rm Tests/AmpHttpClientTest.php
	ephpunit
}
