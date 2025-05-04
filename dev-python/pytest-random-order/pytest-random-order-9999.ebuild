# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 git-r3

DESCRIPTION="pytest plugin to randomise the order of tests"
HOMEPAGE="https://github.com/jbasko/pytest-random-order"
EGIT_REPO_URI="https://github.com/jbasko/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/pytest[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# AttributeError: module 'py' has no attribute 'code'
	tests/test_actual_test_runs.py::test_it_works_with_actual_tests
	tests/test_actual_test_runs.py::test_failed_first
	tests/test_doctests.py::test_doctests
)
