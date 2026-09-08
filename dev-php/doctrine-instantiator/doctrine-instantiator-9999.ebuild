# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_AUTOLOAD="src/Doctrine/Instantiator"
COMPOSER_INSTALL_PATH=""
PHP_REQ_USE="pdo"

inherit composer git-r3

DESCRIPTION="Doctrine Instantiator"
HOMEPAGE="https://github.com/doctrine/instantiator"
EGIT_REPO_URI="https://github.com/doctrine/instantiator.git"

LICENSE="MIT"
SLOT="0"

composer_enable_tests phpunit
