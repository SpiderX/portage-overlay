# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )
EGIT_REPO_URI="https://github.com/dpath-maintainers/${PN}-python.git"

inherit distutils-r1 git-r3

DESCRIPTION="A python module that will check for package updates"
HOMEPAGE="https://github.com/dpath-maintainers/dpath-python"

LICENSE="MIT"
SLOT="0"

BDEPEND="test? ( dev-python/hypothesis[${PYTHON_USEDEP}]
		dev-python/nose2[${PYTHON_USEDEP}] )"

distutils_enable_tests unittest
