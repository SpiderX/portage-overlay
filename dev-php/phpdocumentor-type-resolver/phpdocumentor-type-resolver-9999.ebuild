# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/phpDocumentor/TypeResolver.git"

inherit git-r3

DESCRIPTION="phpDocumentor TypeResolver component"
HOMEPAGE="https://github.com/phpDocumentor/TypeResolver"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*[tokenizer]
	dev-php/doctrine-deprecations
	dev-php/fedora-autoloader
	dev-php/phpdocumentor-reflection-common
	dev-php/phpstan-phpdoc-parser"
BDEPEND="test? ( dev-php/phpunit )"

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		src/TypeResolver/autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
}

src_test() {
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Reflection
	doins -r src/.
}
