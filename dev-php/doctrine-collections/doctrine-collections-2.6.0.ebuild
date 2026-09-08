# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Doctrine/Common/Collections"

inherit composer

DESCRIPTION="Doctrine Collections Abstraction Layer"
HOMEPAGE="https://github.com/doctrine/collections"
SRC_URI="https://github.com/doctrine/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-php/doctrine-deprecations
	dev-php/symfony-polyfill-php84"

EPHPUNIT_BOOTSTRAP='vendor/autoload.php'
COMPOSER_TEST_PATCHES=( "${FILESDIR}/${PN}"-2.6.0-tests-ClosureExpressionVisitorTest.patch )
composer_enable_tests phpunit
