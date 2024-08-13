# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/FriendsOfPHP/proxy-manager-lts.git"

inherit git-r3

DESCRIPTION="Proxy Manager LTS"
HOMEPAGE="https://github.com/FriendsOfPHP/proxy-manager-lts"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="test" # too many errors

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader
	dev-php/laminas-code
	>=dev-php/symfony-filesystem-6.4.9"
BDEPEND="test? ( dev-php/composer
		dev-php/phpunit )"

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		src/ProxyManager/autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
}

src_test() {
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php
	doins -r src/.
}
