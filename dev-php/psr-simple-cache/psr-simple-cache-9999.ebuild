# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Psr/SimpleCache"

inherit composer git-r3

DESCRIPTION="PHP FIG Simple Cache PSR"
HOMEPAGE="https://github.com/php-fig/simple-cache"
EGIT_REPO_URI="https://github.com/php-fig/simple-cache.git"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # no tests
