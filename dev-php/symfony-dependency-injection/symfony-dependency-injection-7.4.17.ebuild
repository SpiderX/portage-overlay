# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Symfony/Component/DependencyInjection"
COMPOSER_INSTALL_SRC="."

inherit composer

DESCRIPTION="Symfony DependencyInjection Component"
HOMEPAGE="https://github.com/symfony/dependency-injection"
SRC_URI="https://github.com/symfony/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-php/psr-container
	dev-php/symfony-deprecation-contracts
	dev-php/symfony-service-contracts
	dev-php/symfony-var-exporter"
BDEPEND="test? ( dev-php/doctrine-deprecations
		dev-php/symfony-config
		dev-php/symfony-expression-language
		dev-php/symfony-phpunit-bridge
		dev-php/symfony-yaml )"

DOCS=( {CHANGELOG,README}.md )

# preload dump generation requires ComposerAutoloaderInit, unavailable with fedora autoloader
EPHPUNIT_EXCLUDE_FILTER='test(Dump|DeprecatedParameters|NonEmptyParameters|NonSharedLazy)AsFiles'
COMPOSER_TEST_PATCHES=(
	"${FILESDIR}/${PN}"-7.4.17-tests-ContainerBuilderTest.patch
	"${FILESDIR}/${PN}"-7.4.17-tests-phpunit.xml.patch )
composer_enable_tests phpunit
