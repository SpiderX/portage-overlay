# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 git-r3

DESCRIPTION="Google Reauth Python Library"
HOMEPAGE="https://github.com/Google/google-reauth-python"
EGIT_REPO_URI="https://github.com/Google/google-reauth-python.git"

LICENSE="Apache-2.0"
SLOT="0"

RDEPEND="dev-python/oauth2client[${PYTHON_USEDEP}]
	dev-python/pyu2f[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
