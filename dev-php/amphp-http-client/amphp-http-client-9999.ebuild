# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 optfeature

DESCRIPTION="Advanced async HTTP client library for PHP"
HOMEPAGE="https://github.com/amphp/http-client"
EGIT_REPO_URI="https://github.com/amphp/http-client.git"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="test" # not ready for phpunit 11

RDEPEND="dev-lang/php:*
	dev-php/amphp-amp
	dev-php/amphp-byte-stream
	dev-php/amphp-hpack
	dev-php/amphp-http
	dev-php/amphp-pipeline
	dev-php/amphp-socket
	dev-php/amphp-sync
	dev-php/fedora-autoloader
	dev-php/league-uri
	dev-php/league-uri-components
	dev-php/league-uri-interfaces
	dev-php/psr-http-message
	dev-php/revolt-event-loop"
BDEPEND="test? ( dev-php/amphp-file
		dev-php/amphp-http-server
		dev-php/laminas-diactoros
		dev-php/phpunit )"

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		src/autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
	# increase timeout
	sed -i '/setTimeout/s|5|10|' test/Connection/StreamLimitingPoolTest.php \
		|| die "sed failed for StreamLimitingPoolTest.php"
	sed -i '/setTimeout/s|4|8|;/setTimeout/s|5|10|;/setTimeout/s|0.10|1|' \
		test/Connection/ConnectionLimitingPoolTest.php \
		|| die "sed failed for ConnectionLimitingPoolTest.php"
	# fix abstract class with Test suffix
	mv test/Interceptor/InterceptorTest{,Abstract}.php || die "mv failed"
	sed -i '/class /s| InterceptorTest| InterceptorTestAbstract|' \
		test/Interceptor/{Add,Remove,Set}RequestHeaderTest.php \
		test/Interceptor/{Add,Remove,Set}ResponseHeaderTest.php \
		test/Interceptor/SetRe{quest,sponse}HeaderIfUnsetTest.php \
		test/Interceptor/{MatchOrigin,LogHttpArchive}Test.php \
		test/Interceptor/{NetworkInterceptor,ForbidUriUserInfo}Test.php \
		test/Interceptor/RetryRequestsTest.php \
		test/Interceptor/ModifyRe{quest,sponse}Test.php \
		test/Interceptor/InterceptorTestAbstract.php || die "sed failed"
	# fix non-static data provider deprecation
	sed -i '/provideStatusCodes(/s|function|static function|' \
		test/ClientHttpBinIntegrationTest.php \
		|| die "sed failed for ClientHttpBinIntegrationTest.php"
	sed -i '/providerValidUriPaths(/s|function|static function|' \
		test/Connection/Http{1,2}ConnectionTest.php \
		|| die "sed failed for providerValidUriPaths"
	sed -i '/provideUris(/s|function|static function|' \
		test/FollowRedirectsTest.php \
		|| die "sed failed for FollowRedirectsTest.php"
	sed -i '/provideInvalidProtocolVersions(/s|function|static function|' \
		test/Re{sponse,quest}Test.php || die "sed failed for provideInvalidProtocolVersions"
}

src_test() {
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Amp/Http/Client
	doins -r src/.
}

pkg_postinst() {
	optfeature "Support for file request bodies and HTTP archive logging" dev-php/amphp-file
}
