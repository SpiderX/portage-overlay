# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="DNS Measurement, Troubleshooting and Security Auditing Toolset"
HOMEPAGE="https://github.com/farrokhi/dnsdiag"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-python/aioquic[${PYTHON_USEDEP}]
	dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/dnspython[${PYTHON_USEDEP}]
	dev-python/h2[${PYTHON_USEDEP}]
	dev-python/httpx[${PYTHON_USEDEP}]
	net-analyzer/cymruwhois[${PYTHON_USEDEP}]"

EPYTEST_XDIST=1
distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# ipv6
	tests/test_dnstraceroute_pytest.py::TestRegressionBugs::test_ipv6_support_issue_45
	tests/test_dnstraceroute_pytest.py::TestAddressFamilyHandling::test_auto_detect_ipv6
	tests/test_dnstraceroute_pytest.py::TestAddressFamilyHandling::test_ipv6_flag_with_hostname
	tests/test_dnstraceroute_pytest.py::TestCLIOptions::test_no_hostname_resolution
	tests/test_dnstraceroute_pytest.py::TestBasicFunctionality::test_basic_ipv6_traceroute
	tests/test_dnstraceroute_pytest.py::TestBasicFunctionality::test_basic_ipv6_traceroute
)
