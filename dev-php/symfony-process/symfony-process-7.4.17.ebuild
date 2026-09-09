# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Symfony/Component/Process"
COMPOSER_INSTALL_SRC="."
PHP_REQ_USE="pcntl?"

inherit composer

DESCRIPTION="Executes commands in sub-processes"
HOMEPAGE="https://github.com/symfony/process"
SRC_URI="https://github.com/symfony/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="pcntl"
REQUIRED_USE="test? ( pcntl )"

BDEPEND="test? ( dev-php/doctrine-deprecations
		dev-php/symfony-deprecation-contracts
		dev-php/symfony-phpunit-bridge )"

DOCS=( {CHANGELOG,README}.md )

COMPOSER_TEST_PATCHES=( "${FILESDIR}/${PN}"-7.4.17-tests.patch )
composer_enable_tests phpunit
