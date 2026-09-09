# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Symfony/Component/Security/Http"
COMPOSER_INSTALL_SRC="."

inherit composer

DESCRIPTION="Symfony Security HTTP Component"
HOMEPAGE="https://github.com/symfony/security-http"
SRC_URI="https://github.com/symfony/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-php/symfony-deprecation-contracts
	dev-php/symfony-event-dispatcher
	dev-php/symfony-http-foundation
	dev-php/symfony-http-kernel
	dev-php/symfony-polyfill-mbstring
	dev-php/symfony-property-access
	dev-php/symfony-security-core
	dev-php/symfony-service-contracts"
BDEPEND="test? ( dev-php/doctrine-deprecations
		dev-php/psr-log
		dev-php/symfony-cache
		dev-php/symfony-clock
		dev-php/symfony-expression-language
		dev-php/symfony-http-client
		dev-php/symfony-http-client-contracts
		dev-php/symfony-phpunit-bridge
		dev-php/symfony-rate-limiter
		dev-php/symfony-routing
		dev-php/symfony-security-csrf
		dev-php/symfony-translation
		dev-php/web-token-jwt-library )"

DOCS=( {CHANGELOG,README}.md )

COMPOSER_TEST_PATCHES=( "${FILESDIR}/${PN}"-7.4.17-tests.patch )
composer_enable_tests phpunit
