# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/DaveRandom/LibDNS.git"

inherit git-r3

DESCRIPTION="DNS implementation in pure PHP"
HOMEPAGE="https://github.com/DaveRandom/LibDNS"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="test" # fails

RDEPEND="dev-lang/php:*[ctype]
	dev-php/daverandom-callback-validator
	dev-php/daverandom-enum
	dev-php/daverandom-network-primitives
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
	insinto /usr/share/php/DaveRandom/LibDNS
	doins -r src/.
}
