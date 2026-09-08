# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Psr/Container"

inherit composer git-r3

DESCRIPTION="Common Container Interface (PHP FIG PSR-11)"
HOMEPAGE="https://github.com/php-fig/container"
EGIT_REPO_URI="https://github.com/php-fig/container.git"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # no tests
