# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="PHP FIG Simple Cache PSR"
HOMEPAGE="https://github.com/php-fig/simple-cache"
EGIT_REPO_URI="https://github.com/php-fig/simple-cache.git"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # no tests

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader"
BDEPEND="dev-php/theseer-Autoload"

src_install() {
	einstalldocs
	insinto /usr/share/php/Psr/SimpleCache
	doins -r "${FILESDIR}"/autoload.php src/.
}
