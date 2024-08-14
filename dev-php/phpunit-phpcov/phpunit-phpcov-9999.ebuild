# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/sebastianbergmann/phpcov.git"

inherit git-r3

DESCRIPTION="TextUI frontend for php-code-coverage"
HOMEPAGE="https://github.com/sebastianbergmann/phpcov"

LICENSE="BSD"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*[phar]
	dev-php/xdebug"
BDEPEND="test? ( dev-php/phpunit )"

DOCS=( {ChangeLog,README}.md )

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
	insinto /usr/share/php/SebastianBergmann/CodeCoverage
	doins -r src/.
}
