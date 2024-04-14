# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..12} )
EGIT_REPO_URI="https://git.code.sf.net/p/${PN}/code"

inherit distutils-r1 git-r3

DESCRIPTION="A library for diffs of python data structures"
HOMEPAGE="https://sourceforge.net/projects/datadiff/"

LICENSE="Apache-2.0"
SLOT="0"

BDEPEND="test? ( dev-python/six[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -type d -name "tests" -exec rm -rv {} + || die "test removing failed"
}
