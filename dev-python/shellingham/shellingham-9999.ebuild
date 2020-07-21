# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..8} )
EGIT_REPO_URI="https://github.com/sarugaku/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Detects what shell the current Python executable is running in"
HOMEPAGE="https://github.com/sarugaku/shellingham"
SRC_URI=""

LICENSE="ISC"
SLOT="0"
KEYWORDS=""
IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="test? ( dev-python/pytest-mock[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
