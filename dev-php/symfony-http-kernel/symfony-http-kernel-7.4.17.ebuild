# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Symfony/Component/HttpKernel"
COMPOSER_INSTALL_SRC="."

inherit composer

DESCRIPTION="Structured process for converting a Request into a Response"
HOMEPAGE="https://github.com/symfony/http-kernel"
SRC_URI="https://github.com/symfony/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-php/symfony-deprecation-contracts
	dev-php/symfony-error-handler
	dev-php/symfony-event-dispatcher
	dev-php/symfony-http-foundation
	dev-php/symfony-polyfill-ctype
	dev-php/psr-log"
BDEPEND="test? ( dev-php/psr-cache
		dev-php/symfony-browser-kit
		dev-php/symfony-clock
		dev-php/symfony-config
		dev-php/symfony-console
		dev-php/symfony-css-selector
		dev-php/symfony-dependency-injection
		dev-php/symfony-dom-crawler
		dev-php/symfony-expression-language
		dev-php/symfony-finder
		dev-php/symfony-http-client-contracts
		dev-php/symfony-phpunit-bridge
		>=dev-php/symfony-process-7
		dev-php/symfony-property-access
		dev-php/symfony-routing
		dev-php/symfony-serializer
		dev-php/symfony-stopwatch
		dev-php/symfony-translation
		dev-php/symfony-translation-contracts
		dev-php/symfony-validator
		dev-php/symfony-var-dumper
		dev-php/symfony-var-exporter
		dev-php/symfony-uid
		>=dev-php/twig-3.12 )"

DOCS=( {CHANGELOG,README}.md )

# exclude test requires generated class starts with ComposerAutoloaderInit
EPHPUNIT_EXCLUDE_FILTER='testGetScript'
COMPOSER_TEST_PATCHES=( "${FILESDIR}/${PN}"-7.4.17-tests.patch )
composer_enable_tests phpunit
