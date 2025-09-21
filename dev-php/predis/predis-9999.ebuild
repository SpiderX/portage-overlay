# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Flexible and feature-complete Redis client for PHP"
HOMEPAGE="https://github.com/predis/predis"
EGIT_REPO_URI="https://github.com/predis/predis.git"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="test" # no support of phpunit 10

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader"
BDEPEND="test? ( dev-php/phpunit )"

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
