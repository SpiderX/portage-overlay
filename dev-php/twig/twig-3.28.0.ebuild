# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Twig"

inherit composer

DESCRIPTION="PHP templating engine with syntax similar to Django"
HOMEPAGE="https://github.com/twigphp/Twig"
SRC_URI="https://github.com/twigphp/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/SpiderX/portage-overlay/releases/download/${P}/${P}-patches.tar.xz"
S="${WORKDIR}/${COMPOSER_PKG^}-${PV}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-php/symfony-deprecation-contracts
	dev-php/symfony-polyfill-ctype
	dev-php/symfony-polyfill-mbstring"
BDEPEND="test? ( dev-php/psr-container
		dev-php/symfony-phpunit-bridge )"

DOCS=( CHANGELOG README.rst )

COMPOSER_TEST_PATCHES=( "${WORKDIR}/${P}-patches/tests" )
composer_enable_tests phpunit
