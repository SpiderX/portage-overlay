# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="ezc/UnitTest"

inherit composer git-r3

DESCRIPTION="Unit tests for any Zeta component"
HOMEPAGE="https://github.com/zetacomponents/UnitTest"
EGIT_REPO_URI="https://github.com/zetacomponents/UnitTest.git"

LICENSE="Apache-2.0"
SLOT="0"
RESTRICT="test" # no tests
