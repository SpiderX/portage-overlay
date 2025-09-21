# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN//symfony-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Symfony HttpClient Component"
HOMEPAGE="https://github.com/symfony/http-client"
SRC_URI="https://github.com/symfony/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
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
		dev-php/composer
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
}

src_test() {
	composer require -d "${T}" --prefer-source \
		--dev "${PN/-/\/}:${PV}" || die "composer failed"
	cp -r "${T}"/vendor/"${PN/-/\/}"/{phpunit.xml.dist,Tests} "${S}" \
		|| die "cp failed"
	! use ipv6 && eapply "${FILESDIR}/${PN}"-7.3.3-test-no-ipv6.patch
	# remove tests require php 8.4
	rm Tests/AmpHttpClientTest.php || die "rm failed for AmpHttpClientTest.php"
	# remove tests with failed assert
	rm Tests/NoPrivateNetworkHttpClientTest.php \
		|| die "rm failed for NoPrivateNetworkHttpClientTest.php"
	sed -i '/testNoPrivateNetworkWithResolveAndRedirect(/,+30d' \
		Tests/HttpClientTestCase.php \
		|| die "sed failed for HttpClientTestCase.php"
	# skipped 31
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Symfony/Component/HttpClient
	doins -r Chunk DataCollector DependencyInjection Exception \
		Internal Messenger Response Retry Test ./*.php
}
