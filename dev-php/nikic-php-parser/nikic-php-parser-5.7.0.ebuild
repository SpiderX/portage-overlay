# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_AUTOLOAD="lib/PhpParser"
COMPOSER_INSTALL_PATH="nikic"
COMPOSER_INSTALL_SRC="lib"
COMPOSER_PKG="PHP-Parser"
PHP_REQ_USE="tokenizer"

inherit composer

DESCRIPTION="A PHP parser written in PHP"
HOMEPAGE="https://github.com/nikic/PHP-Parser"
SRC_URI="https://github.com/nikic/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/SpiderX/portage-overlay/releases/download/${P}/${P}-patches.tar.xz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

PATCHES=( "${WORKDIR}/${P}-patches/src" )

COMPOSER_TEST_PATCHES=( "${WORKDIR}/${P}-patches/tests")
composer_enable_tests phpunit

src_install() {
	composer_src_install
	# install files into COMPOSER_INSTALL_PATH
	dobin bin/php-parse
}
