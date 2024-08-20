# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/doctrine/http-server.git"

inherit git-r3

DESCRIPTION="An advanced async HTTP server library for PHP"
HOMEPAGE="https://github.com/amphp/http-server"

LICENSE="MIT"
SLOT="0"
IUSE="ipv6 test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*[ipv6?]
	dev-php/amphp-amp
	dev-php/amphp-byte-stream
	dev-php/amphp-cache
	dev-php/amphp-hpack
	dev-php/amphp-http
	dev-php/amphp-pipeline
	dev-php/amphp-socket
	dev-php/amphp-sync
	dev-php/fedora-autoloader
	dev-php/league-uri
	dev-php/league-uri-interfaces
	dev-php/psr-http-message
	dev-php/psr-log
	dev-php/revolt-event-loop"
BDEPEND="test? ( dev-php/amphp-http-client
		dev-php/phpunit )"

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		src/autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
	! use ipv6 && eapply "${FILESDIR}/${PN}"-3.3.1-test-no-ipv6.patch
	# fix abstract class with Test suffix
	mv test/Driver/HttpDriverTest{,Abstract}.php || die "mv failed"
	sed -i '/class /s|HttpDriverTest|HttpDriverTestAbstract|' \
		test/Driver/HttpDriverTestAbstract.php \
		test/Driver/Http{1,2}DriverTest.php || die "sed failed"
}

src_test() {
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Amp/Http/Server
	doins -r src/.
}
