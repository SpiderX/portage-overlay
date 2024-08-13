# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/symfony/polyfill-php81.git"

inherit git-r3

DESCRIPTION="Backport of some PHP 8.1+ features to lower PHP versions"
HOMEPAGE="https://github.com/symfony/polyfill-php81"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # no tests

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader"

src_install() {
	einstalldocs
	insinto /usr/share/php/Symfony/Polyfill/Php81
	doins -r Resources "${FILESDIR}"/autoload.php ./*.php
}
