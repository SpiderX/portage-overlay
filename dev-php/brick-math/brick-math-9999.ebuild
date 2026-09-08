# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Brick/Math"
PHP_REQ_USE="bcmath?"

inherit composer git-r3

DESCRIPTION="Arbitrary-precision arithmetic library for PHP"
HOMEPAGE="https://github.com/brick/math"
EGIT_REPO_URI="https://github.com/brick/math.git"

LICENSE="MIT"
SLOT="0"
IUSE="bcmath"
REQUIRED_USE="test? ( bcmath )"

PATCHES=( "${FILESDIR}/${PN}"-0.20.0-tests.patch )

DOCS=( {CHANGELOG,README}.md )

composer_enable_tests phpunit

export CALCULATOR="BCMath"
