# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="AWS Encryption SDK"
HOMEPAGE="https://github.com/aws/aws-encryption-sdk-python"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/attrs[${PYTHON_USEDEP}]
	dev-python/boto3[${PYTHON_USEDEP}]
	dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/wrapt[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/aws-cryptographic-material-providers[${PYTHON_USEDEP}] )"

EPYTEST_XDIST=1
EPYTEST_PLUGINS=( pytest-mock )
distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# TypeError
	test/unit/test_compatability.py::TestWarnDeprecatedPython::test_happy_version
)

EPYTEST_IGNORE=( examples/test test/{integration,mpl/integ} )

pkg_postinst() {
	optfeature "support for MPL" dev-python/aws-cryptographic-material-providers
}
