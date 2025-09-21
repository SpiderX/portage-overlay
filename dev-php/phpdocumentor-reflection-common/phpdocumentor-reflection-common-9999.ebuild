# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="phpDocumentor ReflectionCommon component"
HOMEPAGE="https://github.com/phpDocumentor/ReflectionCommon"
EGIT_REPO_URI="https://github.com/phpDocumentor/ReflectionCommon.git"

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
		src/Common/autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
	# remove not expected elements
	sed -i '9,25d' phpunit.xml.dist || die "sed failed for phpunit.xml.dist"
	# fix non-static data provider deprecation
	sed -i  -e '/ validFqsenProvider(/s|function|static function|' \
		-e '/ invalidFqsenProvider(/s|function|static function|' \
		tests/unit/FqsenTest.php \
		|| die "sed failed for FqsenTest.php"
}

src_compile() { :; }

src_test() {
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/phpDocumentor/Reflection
	doins -r src/.
}
