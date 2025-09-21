# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Utilities to scan PHP code and generate class maps"
HOMEPAGE="https://github.com/composer/class-map-generator"
EGIT_REPO_URI="https://github.com/composer/class-map-generator.git"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*
	dev-php/composer-pcre
	dev-php/fedora-autoloader
	>=dev-php/symfony-finder-6"
BDEPEND="test? ( dev-php/phpunit
		>=dev-php/symfony-filesystem-6 )"

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		src/autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install failed"
	# fix non-static data provider deprecation
	sed -i '/getTestCreateMapTests(/s|function|static function|' \
		tests/ClassMapGeneratorTest.php \
		|| die "sed failed for ClassMapGeneratorTest.php"
}

src_test() {
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Composer/ClassMapGenerator
	doins -r src/.
}
