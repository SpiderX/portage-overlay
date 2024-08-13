# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/composer/class-map-generator.git"

inherit git-r3

DESCRIPTION="Utilities to scan PHP code and generate class maps"
HOMEPAGE="https://github.com/composer/class-map-generator"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*
	dev-php/composer-pcre
	dev-php/fedora-autoloader
	>=dev-php/symfony-finder-6.4.8"
BDEPEND="test? ( dev-php/phpunit
		>=dev-php/symfony-filesystem-6.4.9 )"

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		src/autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install failed"
}

src_test() {
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Composer/ClassMapGenerator
	doins -r src/.
}
