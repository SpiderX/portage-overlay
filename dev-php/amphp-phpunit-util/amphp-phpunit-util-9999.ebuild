# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/amphp/phpunit-util.git"

inherit git-r3

DESCRIPTION="Helper package to ease testing with PHPUnit"
HOMEPAGE="https://github.com/amphp/phpunit-util"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-lang/php:*
	dev-php/amphp-amp
	dev-php/fedora-autoloader
	dev-php/phpunit
	dev-php/revolt-event-loop"

PATCHES=( "${FILESDIR}/${PN}"-3.0.0-phpunit-10.patch )

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
	insinto /usr/share/php/Amp/PHPUnit
	doins -r src/.
}
