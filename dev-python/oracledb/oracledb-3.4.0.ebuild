# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="Python interface to Oracle Database"
HOMEPAGE="https://github.com/oracle/python-oracledb"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test" # needs oracle instance

RDEPEND="dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]"
BDEPEND="dev-python/cython[${PYTHON_USEDEP}]
	test? ( dev-python/anyio[${PYTHON_USEDEP}]
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/pandas[${PYTHON_USEDEP}]
		dev-python/pyarrow[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

pkg_postinst() {
	optfeature "interation with oci" dev-python/oci
	optfeature "intergation with azure" dev-python/msal \
		dev-python/azure-keyvault-secrets dev-python/azure-identity
}
