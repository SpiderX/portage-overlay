# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/phpDocumentor/ReflectionDocBlock.git"

inherit git-r3

DESCRIPTION="phpDocumentor ReflectionDocBlock component"
HOMEPAGE="https://github.com/phpDocumentor/ReflectionDocBlock"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*[filter]
	dev-php/doctrine-deprecations
	dev-php/fedora-autoloader
	dev-php/phpdocumentor-reflection-common
	dev-php/phpdocumentor-type-resolver
	dev-php/phpstan-phpdoc-parser
	dev-php/webmozart-assert"
BDEPEND="test? ( dev-php/mockery
		dev-php/phpunit )"

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		src/DocBlock/autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
}

src_test() {
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/phpDocumentor/Reflection
	doins -r src/.
}
