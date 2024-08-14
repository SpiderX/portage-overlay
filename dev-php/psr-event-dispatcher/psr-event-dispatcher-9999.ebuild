# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/php-fig/event-dispatcher.git"

inherit git-r3

DESCRIPTION="Event Dispatcher Interface (PHP FIG PSR-14)"
HOMEPAGE="https://github.com/php-fig/event-dispatcher"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # no tests

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader"

src_install() {
	einstalldocs
	insinto /usr/share/php/Psr/EventDispatcher
	doins -r "${FILESDIR}"/autoload.php src/.
}
