# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Symfony/Component/EventDispatcher"
COMPOSER_INSTALL_SRC="."

inherit composer

DESCRIPTION="Symfony EventDispatcher Component"
HOMEPAGE="https://github.com/symfony/event-dispatcher"
SRC_URI="https://github.com/symfony/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-php/symfony-event-dispatcher-contracts"
BDEPEND="test? ( dev-php/doctrine-deprecations
		dev-php/psr-log
		dev-php/symfony-config
		dev-php/symfony-dependency-injection
		dev-php/symfony-error-handler
		dev-php/symfony-expression-language
		dev-php/symfony-http-foundation
		dev-php/symfony-phpunit-bridge
		dev-php/symfony-service-contracts
		dev-php/symfony-stopwatch )"

DOCS=( {CHANGELOG,README}.md )

# tests require not packaged FrameworkBundle
EPHPUNIT_EXCLUDE_FILTER='testTagged(Invokable|Multi|MethodUnionType)EventListener'
COMPOSER_TEST_PATCHES=( "${FILESDIR}/${PN}"-7.4.17-tests.patch )
composer_enable_tests phpunit
