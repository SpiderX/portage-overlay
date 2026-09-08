# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="PHPStan/PhpDocParser"

inherit composer

DESCRIPTION="PHPDoc Parser for PHPStan"
HOMEPAGE="https://github.com/phpstan/phpdoc-parser"
SRC_URI="https://github.com/phpstan/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/SpiderX/portage-overlay/releases/download/${P}/${P}-patches.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="test? ( dev-php/doctrine-annotations
		>=dev-php/symfony-process-7
		dev-util/abnfgen )"

EPHPUNIT_BOOTSTRAP='vendor/autoload.php'
COMPOSER_TEST_FILES=( doc )
COMPOSER_TEST_PATCHES=( "${WORKDIR}/${P}-patches/tests" )
composer_enable_tests phpunit
