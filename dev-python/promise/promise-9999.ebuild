# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 git-r3

DESCRIPTION="Ultra-performant Promise implementation in Python"
HOMEPAGE="https://github.com/syrusakbary/promise"
EGIT_REPO_URI="https://github.com/syrusakbary/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/six[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		dev-python/pytest-benchmark[${PYTHON_USEDEP}] )"

PATCHES=( "${FILESDIR}/${PN}"-2.3.0-tests.patch )

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# AttributeError: 'PosixPath' object has no attribute 'strpath'
	tests/test_extra.py::test_thrown_exceptions_have_stacktrace
	tests/test_extra.py::test_thrown_exceptions_preserve_stacktrace
	# async def functions are not natively supported
	tests/test_issues.py::test_issue_9_safe
)
