# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="React/Promise"

inherit composer

DESCRIPTION="A lightweight implementation of CommonJS Promises/A for PHP"
HOMEPAGE="https://github.com/reactphp/promise"
SRC_URI="https://github.com/reactphp/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/SpiderX/portage-overlay/releases/download/${P}/${P}-patches.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

COMPOSER_TEST_PATCHES=( "${WORKDIR}/${P}-patches/tests")
composer_enable_tests phpunit
