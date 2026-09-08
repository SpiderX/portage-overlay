# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Http/Message"
COMPOSER_VENDOR="php-http"
COMPOSER_PKG="${PN#${COMPOSER_VENDOR}-}"

inherit composer git-r3

DESCRIPTION="Httplug Factory interfaces for PSR-7 HTTP Message"
HOMEPAGE="https://github.com/php-http/message-factory"
EGIT_REPO_URI="https://github.com/php-http/message-factory.git"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # no tests

RDEPEND="dev-php/psr-http-message"

DOCS=( {CHANGELOG,README}.md )
