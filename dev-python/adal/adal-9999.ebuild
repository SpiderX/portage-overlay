# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,10} )
PYTHON_REQ_USE="threads(+)"
EGIT_REPO_URI="https://github.com/AzureAD/${MY_PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Library for authentication in Azure Active Directory"
HOMEPAGE="https://github.com/AzureAD/azure-activedirectory-library-for-python"
SRC_URI=""

SLOT="0"
LICENSE="MIT"
KEYWORDS=""

RDEPEND="dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/pyjwt[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/httpretty[${PYTHON_USEDEP}]
		dev-python/six[${PYTHON_USEDEP}] )"

distutils_enable_tests unittest

python_prepare_all() {
	# Disable network test
	rm tests/test_mex.py || die "rm failed"

	distutils-r1_python_prepare_all
}
