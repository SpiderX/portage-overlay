# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="DaveRandom/Enum"

inherit composer

DESCRIPTION="A base class for enumerations in PHP"
HOMEPAGE="https://github.com/DaveRandom/Enum"
SRC_URI="https://github.com/DaveRandom/${COMPOSER_PKG^}/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${COMPOSER_PKG^}-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

COMPOSER_TEST_PATCHES=( "${FILESDIR}/${PN}"-1.0.0-tests.patch )
composer_enable_tests phpunit
