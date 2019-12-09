# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{5..7}} pypy pypy3 )
EGIT_REPO_URI="https://github.com/bigsassy/pytest-pythonpath.git"

inherit distutils-r1 git-r3

DESCRIPTION="plugin for adding to the PYTHONPATH from command line or configs"
HOMEPAGE="https://pypi.org/project/pytest-pythonpath
	https://github.com/bigsassy/pytest-pythonpath"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""
RESTRICT="test"

RDEPEND="dev-python/pytest[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
