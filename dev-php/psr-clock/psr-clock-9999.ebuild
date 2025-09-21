# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Clock Interface (PHP FIG PSR-20)"
HOMEPAGE="https://github.com/php-fig/container"
EGIT_REPO_URI="https://github.com/php-fig/clock.git"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # no tests

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader"

src_install() {
	einstalldocs
	insinto /usr/share/php/Psr/Clock
	doins -r "${FILESDIR}"/autoload.php src/.
}
