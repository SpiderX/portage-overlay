# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Symfony polyfill for ctype functions"
HOMEPAGE="https://github.com/symfony/polyfill-ctype"
EGIT_REPO_URI="https://github.com/symfony/polyfill-ctype.git"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # no tests

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader"

src_install() {
	einstalldocs
	insinto /usr/share/php/Symfony/Polyfill/Ctype
	doins -r "${FILESDIR}"/autoload.php ./*.php
}
