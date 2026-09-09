# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Symfony/Component/VarExporter"
COMPOSER_INSTALL_SRC="."

inherit composer

DESCRIPTION="Symfony VarExporter Component"
HOMEPAGE="https://github.com/symfony/var-exporter"
SRC_URI="https://github.com/symfony/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-php/symfony-deprecation-contracts"
BDEPEND="test? ( dev-php/doctrine-deprecations
		dev-php/symfony-phpunit-bridge
		dev-php/symfony-property-access
		dev-php/symfony-serializer
		dev-php/symfony-var-dumper )"

DOCS=( {CHANGELOG,README}.md )

COMPOSER_TEST_PATCHES=( "${FILESDIR}/${PN}"-7.4.16-tests.patch )
composer_enable_tests phpunit
