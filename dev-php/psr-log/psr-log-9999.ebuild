# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Psr/Log"

inherit composer git-r3

DESCRIPTION="Common interface for logging libraries"
HOMEPAGE="https://github.com/php-fig/log"
EGIT_REPO_URI="https://github.com/php-fig/log.git"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # no tests
