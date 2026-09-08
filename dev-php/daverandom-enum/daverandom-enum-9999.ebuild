# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="DaveRandom/Enum"

inherit composer git-r3

DESCRIPTION="A base class for enumerations in PHP"
HOMEPAGE="https://github.com/DaveRandom/Enum"
EGIT_REPO_URI="https://github.com/DaveRandom/Enum.git"

LICENSE="MIT"
SLOT="0"

PATCHES=( "${FILESDIR}/${PN}"-1.0.0-tests.patch )

composer_enable_tests phpunit
