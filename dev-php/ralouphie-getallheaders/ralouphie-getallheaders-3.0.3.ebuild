# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Ralouphie/Getallheaders"

inherit composer

DESCRIPTION="PHP getallheaders polyfill"
HOMEPAGE="https://github.com/ralouphie/getallheaders"
SRC_URI="https://github.com/ralouphie/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

COMPOSER_TEST_PATCHES=( "${FILESDIR}/${PN}"-3.0.3-tests.patch )
composer_enable_tests phpunit
