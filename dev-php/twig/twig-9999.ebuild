# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="PHP templating engine with syntax similar to Django"
HOMEPAGE="https://github.com/twigphp/Twig"
EGIT_REPO_URI="https://github.com/twigphp/Twig.git"

LICENSE="BSD"
SLOT="0"
IUSE="test"
RESTRICT="test" # not ready for phpunit 11
PROPERTIES="test_network"

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader
	dev-php/symfony-deprecation-contracts
	dev-php/symfony-polyfill-ctype
	dev-php/symfony-polyfill-mbstring
	dev-php/symfony-polyfill-php80"
BDEPEND="test? ( dev-php/phpunit
		dev-php/psr-container
		dev-php/symfony-phpunit-bridge )"

DOCS=( CHANGELOG README.rst )

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		src/autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
}

src_test() {
	# skipped 5
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Twig
	doins -r src/.
}
