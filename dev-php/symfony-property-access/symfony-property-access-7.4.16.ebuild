# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Symfony/Component/PropertyAccess"
COMPOSER_INSTALL_SRC="."

inherit composer

DESCRIPTION="Symfony PropertyAccess Component"
HOMEPAGE="https://github.com/symfony/property-access"
SRC_URI="https://github.com/symfony/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-php/symfony-property-info"
BDEPEND="test? ( dev-php/doctrine-deprecations
		dev-php/symfony-cache
		dev-php/symfony-phpunit-bridge )"

DOCS=( {CHANGELOG,README}.md )

COMPOSER_TEST_PATCHES=( "${FILESDIR}/${PN}"-7.4.16-tests.patch )
composer_enable_tests phpunit
