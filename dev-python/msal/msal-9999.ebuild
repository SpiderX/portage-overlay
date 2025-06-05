# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Microsoft Authentication Library (MSAL) for Python"
HOMEPAGE="https://github.com/AzureAD/microsoft-authentication-library-for-python"
EGIT_REPO_URI="https://github.com/AzureAD/microsoft-authentication-library-for-python.git"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # No module named 'tests'

RDEPEND="dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/pyjwt[${PYTHON_USEDEP}]
	dev-python/python-dotenv[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
