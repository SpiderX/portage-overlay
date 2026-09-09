# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Symfony/Component/Filesystem"
COMPOSER_INSTALL_SRC="."

inherit composer

DESCRIPTION="Provides basic utilities for the filesystem"
HOMEPAGE="https://github.com/symfony/filesystem"
SRC_URI="https://github.com/symfony/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-php/symfony-polyfill-ctype
	dev-php/symfony-polyfill-mbstring"
BDEPEND="test? ( dev-php/doctrine-deprecations
		dev-php/symfony-deprecation-contracts
		dev-php/symfony-phpunit-bridge
		>=dev-php/symfony-process-7 )"

DOCS=( {CHANGELOG,README}.md )

COMPOSER_TEST_PATCHES=( "${FILESDIR}/${PN}"-7.4.17-tests.patch )
composer_enable_tests phpunit
