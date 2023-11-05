# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10,11} )
EGIT_REPO_URI="https://github.com/slashmili/python-jalali.git"

inherit distutils-r1 git-r3

DESCRIPTION="Jalali implementation of Python's datetime module"
HOMEPAGE="https://github.com/slashmili/python-jalali"
SRC_URI=""

LICENSE="PYTHON"
SLOT="0"
KEYWORDS=""

BDEPEND="test? ( dev-python/greenlet[${PYTHON_USEDEP}] )"

DOCS=( CHANGELOG.md README.rst )

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# unsupported locale setting
	tests/test_jdatetime.py::TestJDateTime::test_with_fa_locale
)
