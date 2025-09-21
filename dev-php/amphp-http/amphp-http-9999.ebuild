# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="HTTP primitives which can be shared by servers and clients"
HOMEPAGE="https://github.com/amphp/http"
EGIT_REPO_URI="https://github.com/amphp/http.git"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*
	dev-php/amphp-hpack
	dev-php/amphp-parser
	dev-php/fedora-autoloader
	dev-php/league-uri-components
	dev-php/psr-http-message"
BDEPEND="test? ( dev-php/phpunit )"

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		src/autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
	# fix abstract class with Test suffix
	mv test/HeaderParsingTest{,Abstract}.php || die "mv failed"
	sed -i '/class /s|HeaderParsingTest|HeaderParsingTestAbstract|' \
		test/HeaderParsingTestAbstract.php test/SplitHeaderTest.php \
		test/ParseHeaderFieldsTest.php || die "sed failed"
	# fix non-static data provider deprecation
	sed -i  -e '/provideValidHeaders(/s|function|static function|g' \
		-e '/provideInvalidHeaders(/s|function|static function|' \
		test/Http1/Rfc7230Test.php \
		|| die "sed failed for Rfc7230Test.php"
	sed -i '/provideStatuses(/s|function|static function|' \
		test/HttpResponseTest.php \
		|| die "sed failed for HttpResponseTest.php"
	sed -i  -e '/provideMultipleHeaderCases(/s|function|static function|' \
		-e '/provideTokenCases(/s|function|static function|' \
		test/ParseHeaderFieldsTest.php \
		|| die "sed failed for ParseHeaderFieldsTest.php"
	sed -i '/provideCases(/s|function|static function|' \
		test/SplitHeaderTest.php \
		|| die "sed failed for SplitHeaderTest.php"
}

src_test() {
	# php.ini must have zend.assertions = 1
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Amp/Http
	doins -r src/.
}
