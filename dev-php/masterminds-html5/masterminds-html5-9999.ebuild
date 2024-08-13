# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/Masterminds/html5-php.git"

inherit git-r3

DESCRIPTION="An HTML5 parser and serializer for PHP"
HOMEPAGE="https://github.com/Masterminds/html5-php"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*[xml]
	dev-php/fedora-autoloader"
BDEPEND="test? ( dev-php/phpunit )"

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		src/autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
	# replace deprecated method
	sed -i 's/assertRegExp/assertMatchesRegularExpression/' \
		test/HTML5/{Html5Test,Serializer/OutputRulesTest}.php \
		|| die "sed failed"
}

src_test() {
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Masterminds
	doins -r src/.
}
