# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Symfony/Component/Emoji"
COMPOSER_INSTALL_SRC="."
PHP_REQ_USE="intl"

inherit composer

DESCRIPTION="Provides access to emoji characters"
HOMEPAGE="https://github.com/symfony/emoji"
SRC_URI="https://github.com/symfony/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="test? ( dev-php/doctrine-deprecations
		dev-php/symfony-deprecation-contracts
		>=dev-php/symfony-finder-7
		dev-php/symfony-phpunit-bridge )"

DOCS=( {CHANGELOG,README}.md )

composer_enable_tests phpunit
