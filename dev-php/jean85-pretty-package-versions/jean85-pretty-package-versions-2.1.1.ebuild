# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Jean85"
PHP_REQ_USE="intl?"

inherit composer

DESCRIPTION="Independent wrapper to get pretty versions strings"
HOMEPAGE="https://github.com/Jean85/pretty-package-versions"
SRC_URI="https://github.com/Jean85/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="intl"
REQUIRED_USE="test? ( intl )"

RDEPEND="dev-php/composer"

COMPOSER_TEST_PATCHES=( "${FILESDIR}/${PN}"-2.1.1-tests.patch )
composer_enable_tests phpunit
