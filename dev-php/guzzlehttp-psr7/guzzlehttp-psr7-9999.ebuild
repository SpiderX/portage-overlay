# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/guzzle/promises.git"

inherit git-r3

DESCRIPTION="PSR-7 HTTP message library"
HOMEPAGE="https://github.com/guzzle/psr7"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader
	dev-php/psr-http-factory
	dev-php/psr-http-message
	dev-php/ralouphie-getallheaders"
BDEPEND="test? ( dev-php/http-interop-http-factory-tests
		dev-php/phpunit )"

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		src/autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
	mkdir -p vendor/http-interop/http-factory-tests || die "mkdir failed"
	ln -s ../../../../../../../../../../usr/share/php/Interop/Http/Factory/ \
		vendor/http-interop/http-factory-tests/test \
		|| die "ln failed"
	# remove test with deprecated method
	sed -i '/testReturnsFalseWhenStreamDoesNotExist/,+5d' \
		tests/StreamWrapperTest.php || die "sed failed"
}

src_test() {
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/GuzzleHttp/Psr7
	doins -r src/.
}
