# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/amphp/http.git"

inherit git-r3

DESCRIPTION="A fiber-aware cache API"
HOMEPAGE="https://github.com/amphp/cache"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*
	dev-php/amphp-amp
	dev-php/amphp-serialization
	dev-php/amphp-sync
	dev-php/fedora-autoloader
	dev-php/revolt-event-loop"
BDEPEND="test? ( dev-php/phpunit )"

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		src/autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
	# fix abstract class with Test suffix
	mv test/StringCacheTest{,Abstract}.php || die "mv failed"
	sed -i '/class /s|StringCacheTest|StringCacheTestAbstract|' \
		test/StringCacheTestAbstract.php test/{Local,Prefix}CacheTest.php \
		test/LocalCacheLimitedTest.php || die "sed failed"
}

src_test() {
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Amp/Cache
	doins -r src/.
}
