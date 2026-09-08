# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_AUTOLOAD="src/Prophecy"
COMPOSER_INSTALL_PATH="phpspec"

inherit composer

DESCRIPTION="Highly opinionated mocking framework for PHP"
HOMEPAGE="https://github.com/phpspec/prophecy"
SRC_URI="https://github.com/phpspec/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-php/doctrine-instantiator-2.1.0
	dev-php/phpdocumentor-reflection-docblock
	dev-php/sebastian-comparator
	dev-php/sebastian-recursion-context
	dev-php/symfony-deprecation-contracts"

COMPOSER_TEST_FILES=( fixtures )
composer_enable_tests phpunit
