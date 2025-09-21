# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Common Cache Interface (PHP FIG PSR-6)"
HOMEPAGE="https://github.com/php-fig/cache"
EGIT_REPO_URI="https://github.com/php-fig/cache.git"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # no tests

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader"

src_install() {
	einstalldocs
	insinto /usr/share/php/Psr/Cache
	doins -r "${FILESDIR}"/autoload.php src/.
}
