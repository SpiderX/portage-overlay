# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="PHP getallheaders polyfill"
HOMEPAGE="https://github.com/ralouphie/getallheaders"
EGIT_REPO_URI="https://github.com/ralouphie/getallheaders.git"

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
	# fix non-static data provider deprecation
	sed -i '/dataWorks(/s|function|static function|' \
		tests/GetAllHeadersTest.php \
		|| die "sed failed for CompliesTest.php"
}

src_test() {
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Ralouphie/Getallheaders
	doins -r src/.
}
