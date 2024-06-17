# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )
EGIT_REPO_URI="https://github.com/mahmoud/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Straightforward CLI parsing and dispatching microframework"
HOMEPAGE="https://github.com/mahmoud/face"

LICENSE="BSD"
SLOT="0"

RDEPEND="dev-python/boltons[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# AssertionError: assert 'python3.12 -m search_pkg' == 'python -m search_pkg'
	face/test/test_search_cmd.py::test_search_prs_basic
)

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -type d -name "test" -exec rm -rv {} + || die "tests removing failed"
}
