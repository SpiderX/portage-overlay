# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/laminas/laminas-code.git"

DESCRIPTION="Extensions to the PHP Reflection API"
HOMEPAGE="https://github.com/laminas/laminas-code"

LICENSE="BSD"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*[phar]
	dev-php/fedora-autoloader"
BDEPEND="test? ( dev-php/doctrine-annotations
		dev-php/laminas-stdlib
		dev-php/phpunit )"

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		src/autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
}

src_test() {
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Laminas/Code
	doins -r src/.
}
