# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Symfony/Component/Ldap"
COMPOSER_INSTALL_SRC="."
PHP_REQ_USE="ldap"

inherit composer

DESCRIPTION="Symfony Ldap Component"
HOMEPAGE="https://github.com/symfony/ldap"
SRC_URI="https://github.com/symfony/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-php/symfony-options-resolver"
BDEPEND="test? ( dev-php/doctrine-deprecations
		dev-php/symfony-phpunit-bridge
		dev-php/symfony-security-core
		dev-php/symfony-security-http )"

DOCS=( {CHANGELOG,README}.md )

COMPOSER_TEST_PATCHES=( "${FILESDIR}/${PN}"-7.4.10-tests.patch )
composer_enable_tests phpunit
