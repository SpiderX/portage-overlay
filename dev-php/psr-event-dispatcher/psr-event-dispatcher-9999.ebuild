# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Psr/EventDispatcher"

inherit composer git-r3

DESCRIPTION="Event Dispatcher Interface (PHP FIG PSR-14)"
HOMEPAGE="https://github.com/php-fig/event-dispatcher"
EGIT_REPO_URI="https://github.com/php-fig/event-dispatcher.git"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # no tests
