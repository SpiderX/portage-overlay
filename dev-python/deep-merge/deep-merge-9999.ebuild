# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 git-r3

DESCRIPTION="A simple utility for merging python dictionaries"
HOMEPAGE="https://github.com/halfak/deep_merge"
EGIT_REPO_URI="https://github.com/halfak/${PN}.git"

LICENSE="MIT"
SLOT="0"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# AssertionError
	deep_merge/tests/test_merge.py::test_big_merge
	deep_merge/tests/test_merge.py::test_no_references
)

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -type d -name "tests" -exec rm -rv {} + || die "tests removing failed"
}
