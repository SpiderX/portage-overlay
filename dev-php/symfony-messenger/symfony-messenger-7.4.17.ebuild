# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Symfony/Component/Messenger"
COMPOSER_INSTALL_SRC="."

inherit composer

DESCRIPTION="Symfony Messenger Component"
HOMEPAGE="https://github.com/symfony/messenger"
SRC_URI="https://github.com/symfony/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-php/psr-log
	dev-php/symfony-deprecation-contracts
	dev-php/symfony-clock"
BDEPEND="test? ( dev-php/symfony-amqp-messenger
		dev-php/symfony-console
		dev-php/symfony-dependency-injection
		dev-php/symfony-doctrine-messenger
		dev-php/symfony-event-dispatcher
		dev-php/symfony-error-handler
		dev-php/symfony-http-kernel
		dev-php/symfony-lock
		dev-php/symfony-phpunit-bridge
		dev-php/symfony-rate-limiter
		dev-php/symfony-routing
		dev-php/symfony-serializer
		dev-php/symfony-stopwatch
		dev-php/symfony-validator )"

DOCS=( {CHANGELOG,README}.md )

COMPOSER_TEST_PATCHES=( "${FILESDIR}/${PN}"-7.4.17-tests.patch )
composer_enable_tests phpunit
