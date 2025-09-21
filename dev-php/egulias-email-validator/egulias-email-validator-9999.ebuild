# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="PHP Email address validator"
HOMEPAGE="https://github.com/egulias/EmailValidator"
EGIT_REPO_URI="https://github.com/egulias/EmailValidator.git"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*
	dev-php/doctrine-lexer
	dev-php/fedora-autoloader
	dev-php/symfony-polyfill-intl-idn"
BDEPEND="test? ( dev-php/phpunit )"

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		src/autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
}

src_test() {
	# skipped — testDNSWarnings, testInvalidUTF16
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Egulias/EmailValidator
	doins -r src/.
}
