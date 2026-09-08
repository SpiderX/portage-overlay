# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Symfony/Component/Messenger/Bridge/Doctrine"
COMPOSER_INSTALL_SRC="."

inherit composer

DESCRIPTION="Symfony Doctrine Messenger"
HOMEPAGE="https://github.com/symfony/doctrine-messenger"
SRC_URI="https://github.com/symfony/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-php/doctrine-dbal
	dev-php/symfony-messenger
	dev-php/symfony-service-contracts"
BDEPEND="test? ( dev-php/doctrine-persistence
		dev-php/symfony-property-access
		dev-php/symfony-serializer )"

DOCS=( {CHANGELOG,README}.md )

composer_enable_tests phpunit
