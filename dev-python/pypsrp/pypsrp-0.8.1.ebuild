# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="PowerShell Remoting Protocol and WinRM for Python"
HOMEPAGE="https://github.com/jborean93/pypsrp"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND="dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/pyspnego[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]"
BDEPEND="test? ( app-text/xmldiff[${PYTHON_USEDEP}]
		dev-python/pytest-mock[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
		dev-python/requests-credssp[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# AssertionError
	tests/test_host.py::TestPSHostUserInterface::test_psrp_pshost_ui_mocked_methods
	tests/test_powershell.py::TestRunspacePool::test_psrp_key_exchange_timeout
	tests/test_powershell.py::TestPSRPScenarios::test_psrp_multiple_commands
)

pkg_postinst() {
	optfeature "support credssp" dev-python/requests-credssp
	optfeature "support kerberos" dev-python/gssapi dev-python/krb5
}
