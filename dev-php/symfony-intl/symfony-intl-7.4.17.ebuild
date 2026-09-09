# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Symfony/Component/Intl"
COMPOSER_INSTALL_SRC="."

inherit composer

DESCRIPTION="Symfony Intl Component"
HOMEPAGE="https://github.com/symfony/intl"
SRC_URI="https://github.com/symfony/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-php/symfony-deprecation-contracts"
BDEPEND="test? ( dev-php/symfony-deprecation-contracts
		>=dev-php/symfony-filesystem-7.1
		dev-php/symfony-phpunit-bridge
		dev-php/symfony-var-exporter )"

DOCS=( {CHANGELOG,README}.md )

COMPOSER_TEST_PATCHES=( "${FILESDIR}/${PN}"-7.4.17-tests.patch )
composer_enable_tests phpunit
