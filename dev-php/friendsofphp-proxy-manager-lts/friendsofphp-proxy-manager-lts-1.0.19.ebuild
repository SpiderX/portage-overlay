# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_AUTOLOAD="src/ProxyManager"
COMPOSER_INSTALL_PATH=""

inherit composer

DESCRIPTION="Proxy Manager LTS"
HOMEPAGE="https://github.com/FriendsOfPHP/proxy-manager-lts"
SRC_URI="https://github.com/FriendsOfPHP/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/SpiderX/portage-overlay/releases/download/${P}/${P}-patches.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-php/laminas-code
	>=dev-php/symfony-filesystem-6.4.9"

COMPOSER_TEST_PATCHES=( "${WORKDIR}/${P}-patches/tests" )
composer_enable_tests phpunit
