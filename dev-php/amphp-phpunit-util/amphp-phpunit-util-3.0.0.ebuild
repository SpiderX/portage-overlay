# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN//amphp-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Helper package to ease testing with PHPUnit"
HOMEPAGE="https://github.com/amphp/phpunit-util"
SRC_URI="https://github.com/amphp/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test" # not ready for phpunit 11

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
