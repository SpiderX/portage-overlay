# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/symfony/polyfill-php80.git"

inherit git-r3

DESCRIPTION="Backport of some PHP 8.0+ features to lower PHP versions"
HOMEPAGE="https://github.com/symfony/polyfill-php80"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # no tests

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader"

src_install() {
	einstalldocs
	insinto /usr/share/php/Symfony/Polyfill/Php80
	doins -r Resources "${FILESDIR}"/autoload.php ./*.php
}
