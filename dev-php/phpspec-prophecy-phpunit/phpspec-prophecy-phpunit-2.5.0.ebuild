# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="phpspec/Prophecy/PhpUnit"

inherit composer

DESCRIPTION="Integrating Prophecy in PHPUnit test cases"
HOMEPAGE="https://github.com/phpspec/prophecy-phpunit"
SRC_URI="https://github.com/phpspec/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-php/phpspec-prophecy
	dev-php/phpunit"

COMPOSER_TEST_FILES=( fixtures )
composer_enable_tests phpunit
