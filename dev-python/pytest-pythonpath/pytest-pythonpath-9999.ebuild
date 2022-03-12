# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( pypy3 python3_{8..10} )
EGIT_REPO_URI="https://github.com/bigsassy/pytest-pythonpath.git"

inherit distutils-r1 git-r3

DESCRIPTION="plugin for adding to the PYTHONPATH from command line or configs"
HOMEPAGE="https://github.com/bigsassy/pytest-pythonpath"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND="<dev-python/pytest-7[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
