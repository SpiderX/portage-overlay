# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Symfony/Contracts/EventDispatcher"
COMPOSER_INSTALL_SRC="."

inherit composer

DESCRIPTION="A set of event dispatcher abstractions"
HOMEPAGE="https://github.com/symfony/event-dispatcher-contracts"
SRC_URI="https://github.com/symfony/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # no tests

RDEPEND="dev-php/psr-event-dispatcher"

DOCS=( {CHANGELOG,README}.md )
