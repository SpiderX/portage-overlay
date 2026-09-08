# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Brick/Math"
PHP_REQ_USE="bcmath?"

inherit composer

DESCRIPTION="Arbitrary-precision arithmetic library for PHP"
HOMEPAGE="https://github.com/brick/math"
SRC_URI="https://github.com/brick/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="bcmath"
REQUIRED_USE="test? ( bcmath )"

DOCS=( {CHANGELOG,README}.md )

COMPOSER_TEST_FILES=( phpunit.php )
COMPOSER_TEST_PATCHES=( "${FILESDIR}/${PN}"-0.20.0-tests.patch )
composer_enable_tests phpunit

export CALCULATOR="BCMath"
