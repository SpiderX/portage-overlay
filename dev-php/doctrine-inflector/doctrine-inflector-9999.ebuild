# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Doctrine/Inflector"

inherit composer git-r3

DESCRIPTION="Doctrine Inflector"
HOMEPAGE="https://github.com/doctrine/inflector"
EGIT_REPO_URI="https://github.com/doctrine/inflector.git"

LICENSE="MIT"
SLOT="0"

EPHPUNIT_BOOTSTRAP='vendor/autoload.php'
composer_enable_tests phpunit
