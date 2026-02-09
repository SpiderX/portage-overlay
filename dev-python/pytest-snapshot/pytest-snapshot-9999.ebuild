# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 git-r3

DESCRIPTION="A plugin for snapshot testing with pytest"
HOMEPAGE="https://github.com/joseph-roitman/pytest-snapshot"
EGIT_REPO_URI="https://github.com/joseph-roitman/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/pytest[${PYTHON_USEDEP}]"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# https://github.com/joseph-roitman/pytest-snapshot/issues/71
	tests/test_assert_match.py::test_assert_match_failure_bytes
)
