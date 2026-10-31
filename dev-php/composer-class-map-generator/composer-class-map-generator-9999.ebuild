# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Composer/ClassMapGenerator"

inherit composer git-r3

DESCRIPTION="Utilities to scan PHP code and generate class maps"
HOMEPAGE="https://github.com/composer/class-map-generator"
EGIT_REPO_URI="https://github.com/composer/class-map-generator.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-php/composer-pcre
	>=dev-php/symfony-finder-7"
BDEPEND="test? ( >=dev-php/symfony-filesystem-7 )"

PATCHES=( "${FILESDIR}/${PN}"-1.8.0-tests-ClassMapGeneratorTest.patch
	"${FILESDIR}/${PN}"-1.8.0-tests-ClassMapTest.patch )

composer_enable_tests phpunit
