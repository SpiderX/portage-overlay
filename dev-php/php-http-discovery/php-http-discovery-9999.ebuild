# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Http/Discovery"
COMPOSER_VENDOR="php-http"
COMPOSER_PKG="${PN#${COMPOSER_VENDOR}-}"

inherit composer git-r3

DESCRIPTION="The HTTP client abstraction for PHP"
HOMEPAGE="https://github.com/php-http/httplug"
EGIT_REPO_URI="https://github.com/php-http/httplug.git"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # no tests

DOCS=( {CHANGELOG,README}.md )
