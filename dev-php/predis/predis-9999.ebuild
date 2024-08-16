# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/predis/predis.git"

inherit git-r3

DESCRIPTION="Flexible and feature-complete Redis client for PHP"
HOMEPAGE="https://github.com/predis/predis"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # no support of phpunit 10

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader"

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		src/autoload.php || die "install failed"
}

src_test() {
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Predis
	doins -r src/.
}
