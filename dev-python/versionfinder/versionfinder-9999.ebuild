# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..12} )
EGIT_REPO_URI="https://github.com/jantman/versionfinder.git"

inherit distutils-r1 git-r3

DESCRIPTION="Find version of python package, installed via pip, setuptools, git"
HOMEPAGE="https://github.com/jantman/versionfinder"
SRC_URI=""

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS=""
IUSE="test"
RESTRICT="test" # requires git repository

RDEPEND="dev-python/gitpython[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="test? ( dev-python/pip[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/backoff[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -type d -name "tests" -exec rm -rv {} + || die "test removing failed"
}
