# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Find the system CA bundle or fall back to the Mozilla one"
HOMEPAGE="https://github.com/composer/ca-bundle"
EGIT_REPO_URI="https://github.com/composer/semver.git"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="!dev-php/ca-bundle
	dev-lang/php:*[ssl]
	dev-php/fedora-autoloader"
BDEPEND="test? ( dev-php/phpunit )"

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
	insinto /usr/share/php/Composer/CaBundle
	doins -r src/.
	insinto /usr/share/composer/res
	doins -r res/.
}
