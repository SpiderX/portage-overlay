# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Symfony/Component/Console"
COMPOSER_INSTALL_SRC="."

inherit composer

DESCRIPTION="Eases the creation of beautiful and testable command line interfaces"
HOMEPAGE="https://github.com/symfony/console"
SRC_URI="https://github.com/symfony/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-php/symfony-deprecation-contracts
	dev-php/symfony-polyfill-mbstring
	dev-php/symfony-service-contracts
	dev-php/symfony-string"
BDEPEND="test? ( dev-php/doctrine-deprecations
		dev-php/psr-log
		dev-php/symfony-config
		dev-php/symfony-dependency-injection
		dev-php/symfony-event-dispatcher
		dev-php/symfony-http-foundation
		dev-php/symfony-http-kernel
		dev-php/symfony-lock
		dev-php/symfony-messenger
		dev-php/symfony-phpunit-bridge
		>=dev-php/symfony-process-6
		dev-php/symfony-stopwatch
		dev-php/symfony-var-dumper )"

DOCS=( {CHANGELOG,README}.md )

# exclude test requires an interactive STDIN
EPHPUNIT_EXCLUDE_FILTER='testAskTimeout'
COMPOSER_TEST_PATCHES=(
	"${FILESDIR}/${PN}"-7.4.17-tests-QuestionHelperTest.patch
	"${FILESDIR}/${PN}"-7.4.17-tests-phpunit.xml.patch )
composer_enable_tests phpunit
