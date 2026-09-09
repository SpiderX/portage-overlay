# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Symfony/Polyfill/Php85"
COMPOSER_INSTALL_SRC="."

inherit composer git-r3

DESCRIPTION="Backport of some PHP 8.5+ features to lower PHP versions"
HOMEPAGE="https://github.com/symfony/polyfill-php85"
EGIT_REPO_URI="https://github.com/symfony/polyfill-php85.git"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # no tests
