# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Symfony HttpClient Component"
HOMEPAGE="https://github.com/symfony/http-client"
EGIT_REPO_URI="https://github.com/symfony/http-client.git"

LICENSE="MIT"
SLOT="0"
IUSE="ipv6 test"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader
	dev-php/psr-log
	dev-php/symfony-deprecation-contracts
	dev-php/symfony-http-client-contracts
	dev-php/symfony-polyfill-php83
	dev-php/symfony-service-contracts"
BDEPEND="test? ( dev-php/amphp-http-client
		dev-php/guzzlehttp-promises
		dev-php/nyholm-psr7
		dev-php/php-http-httplug
		dev-php/phpunit
		dev-php/psr-http-client
		dev-php/symfony-dependency-injection
		dev-php/symfony-http-kernel
		dev-php/symfony-phpunit-bridge
		>=dev-php/symfony-process-6
		dev-php/symfony-rate-limiter
		dev-php/symfony-stopwatch )"

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
	! use ipv6 && eapply "${FILESDIR}/${PN}"-7.3.3-test-no-ipv6.patch
	# remove tests require php 8.4
	rm Tests/AmpHttpClientTest.php || die "rm failed for AmpHttpClientTest.php"
	# remove tests with failed assert
	rm Tests/NoPrivateNetworkHttpClientTest.php \
		|| die "rm failed for NoPrivateNetworkHttpClientTest.php"
	sed -i '/testNoPrivateNetworkWithResolveAndRedirect(/,+30d' \
		Tests/HttpClientTestCase.php \
		|| die "sed failed for HttpClientTestCase.php"
}

src_test() {
	# skipped 31
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Symfony/Component/HttpClient
	doins -r Chunk DataCollector DependencyInjection Exception \
		Internal Messenger Response Retry Test ./*.php
}
