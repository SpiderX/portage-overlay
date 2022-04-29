# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )
EGIT_REPO_URI="https://github.com/wmayner/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Fast EMD for Python"
HOMEPAGE="https://github.com/wmayner/pyemd"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="test"

RDEPEND="dev-python/numpy[${PYTHON_USEDEP}]"
BDEPEND="dev-python/cython[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

python_compile_all() {
	use test && esetup.py build_ext --inplace
}
