# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Doctrine/Inflector"

inherit composer

DESCRIPTION="Doctrine Inflector"
HOMEPAGE="https://github.com/doctrine/inflector"
SRC_URI="https://github.com/doctrine/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

EPHPUNIT_BOOTSTRAP='vendor/autoload.php'
composer_enable_tests phpunit
