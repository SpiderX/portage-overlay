# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..12} )
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

distutils_enable_tests unittest
