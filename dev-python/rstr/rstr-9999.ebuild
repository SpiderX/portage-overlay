# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Generate random strings in Python"
HOMEPAGE="https://github.com/leapfrogonline/rstr"
EGIT_REPO_URI="https://github.com/leapfrogonline/${PN}.git"

LICENSE="BSD"
SLOT=0

BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]"

distutils_enable_tests unittest
