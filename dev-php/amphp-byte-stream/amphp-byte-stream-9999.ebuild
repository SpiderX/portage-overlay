# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="A non-blocking stream abstraction for PHP based on Amp"
HOMEPAGE="https://github.com/amphp/byte-stream"
EGIT_REPO_URI="https://github.com/amphp/byte-stream.git"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*
	dev-php/amphp-amp
	dev-php/amphp-parser
	dev-php/amphp-pipeline
	dev-php/amphp-serialization
	dev-php/amphp-sync
	dev-php/fedora-autoloader
	dev-php/revolt-event-loop"
BDEPEND="test? ( dev-php/phpunit )"

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		src/autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
	# fix non-static data provider deprecation
	sed -i '/provideEngineIterables(/s|function|static function|' \
		test/ReadableIterableStreamTest.php \
		|| die "sed failed for ReadableIterableStreamTest.php"
}

src_test() {
	# skipped — testIssue47
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Amp/ByteStream
	doins -r src/.
}
