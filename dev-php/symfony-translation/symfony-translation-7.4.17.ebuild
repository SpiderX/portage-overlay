# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Symfony/Component/Translation"
COMPOSER_INSTALL_SRC="."

inherit composer

DESCRIPTION="Symfony Translation Component"
HOMEPAGE="https://github.com/symfony/translation"
SRC_URI="https://github.com/symfony/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-php/symfony-deprecation-contracts
	dev-php/symfony-polyfill-mbstring
	dev-php/symfony-translation-contracts"
BDEPEND="test? ( dev-php/doctrine-deprecations
		dev-php/nikic-php-parser
		dev-php/symfony-config
		dev-php/symfony-console
		dev-php/symfony-dependency-injection
		>=dev-php/symfony-finder-7
		dev-php/symfony-http-client-contracts
		dev-php/symfony-http-kernel
		dev-php/symfony-phpunit-bridge
		dev-php/symfony-routing
		dev-php/symfony-yaml )"

DOCS=( {CHANGELOG,README}.md )

COMPOSER_TEST_PATCHES=( "${FILESDIR}/${PN}"-7.4.17-tests.patch )
composer_enable_tests phpunit
