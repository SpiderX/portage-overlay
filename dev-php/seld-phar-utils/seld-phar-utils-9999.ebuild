# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Seld/PharUtils"
PHP_REQ_USE="phar"

inherit composer git-r3

DESCRIPTION="PHAR file format utilities, for when PHP phars you up"
HOMEPAGE="https://github.com/Seldaek/phar-utils"
EGIT_REPO_URI="https://github.com/Seldaek/phar-utils.git"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # no tests
