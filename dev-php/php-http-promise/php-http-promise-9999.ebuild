# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Http/Promise"
COMPOSER_VENDOR="php-http"
COMPOSER_PKG="${PN#${COMPOSER_VENDOR}-}"

inherit composer git-r3

DESCRIPTION="Promise used for asynchronous HTTP requests"
HOMEPAGE="https://github.com/php-http/promise"
EGIT_REPO_URI="https://github.com/php-http/promise.git"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # no tests

DOCS=( {CHANGELOG,README}.md )
