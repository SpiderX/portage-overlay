# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )
EGIT_REPO_URI="https://github.com/fitnr/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Utils for converting between date formats and calculating holidays"
HOMEPAGE="https://github.com/fitnr/convertdate"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-python/PyMeeus[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

distutils_enable_tests unittest
