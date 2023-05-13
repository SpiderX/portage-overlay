# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,10} )
PYTHON_REQ_USE="threads(+)"

inherit distutils-r1

MY_PN="azure-activedirectory-library-for-python"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Library for authentication in Azure Active Directory"
HOMEPAGE="https://github.com/AzureAD/azure-activedirectory-library-for-python"
SRC_URI="https://github.com/AzureAD/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/pyjwt[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/httpretty[${PYTHON_USEDEP}]
		dev-python/six[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${MY_P}"

distutils_enable_tests unittest

python_prepare_all() {
	# Disable network test
	rm tests/test_mex.py || die "rm failed"

	distutils-r1_python_prepare_all
}
