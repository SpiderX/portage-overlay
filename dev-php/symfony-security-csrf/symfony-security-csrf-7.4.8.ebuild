# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Symfony/Component/Security/Csrf"
COMPOSER_INSTALL_SRC="."

inherit composer

DESCRIPTION="Symfony Security CSRF Component"
HOMEPAGE="https://github.com/symfony/security-csrf"
SRC_URI="https://github.com/symfony/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-php/symfony-security-core"
BDEPEND="test? ( dev-php/doctrine-deprecations
		dev-php/psr-log
		dev-php/symfony-http-foundation
		dev-php/symfony-http-kernel
		dev-php/symfony-phpunit-bridge )"

DOCS=( {CHANGELOG,README}.md )

composer_enable_tests phpunit
