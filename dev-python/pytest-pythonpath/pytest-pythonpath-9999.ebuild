# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( pypy3 python3_{11..13} )

inherit distutils-r1 git-r3

DESCRIPTION="plugin for adding to the PYTHONPATH from command line or configs"
HOMEPAGE="https://github.com/bigsassy/pytest-pythonpath"
EGIT_REPO_URI="https://github.com/bigsassy/pytest-pythonpath.git"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # not configured test

RDEPEND="dev-python/pytest[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
