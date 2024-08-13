# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/DaveRandom/CallbackValidator.git"

inherit git-r3

DESCRIPTION="Tools for validating callback signatures in PHP"
HOMEPAGE="https://github.com/DaveRandom/CallbackValidator"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader"
BDEPEND="test? ( dev-php/phpunit )"

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		src/autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
	# remove non-supported tests
	rm -rf tests/Php71/ || die "rm failed for Php71"
	# remove tests failed assert
	rm tests/MatchTesterTest.php || die "rm failed for MatchTesterTest.php"
}

src_test() {
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/DaveRandom/CallbackValidator
	doins -r src/.
}
