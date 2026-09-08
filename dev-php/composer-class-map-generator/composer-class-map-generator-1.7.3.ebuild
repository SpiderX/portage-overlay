# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Composer/ClassMapGenerator"

inherit composer

DESCRIPTION="Utilities to scan PHP code and generate class maps"
HOMEPAGE="https://github.com/composer/class-map-generator"
SRC_URI="https://github.com/composer/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-php/composer-pcre
	>=dev-php/symfony-finder-7"
BDEPEND="test? ( >=dev-php/symfony-filesystem-7 )"

COMPOSER_TEST_PATCHES=( "${FILESDIR}/${PN}"-1.7.3-tests.patch )
composer_enable_tests phpunit
