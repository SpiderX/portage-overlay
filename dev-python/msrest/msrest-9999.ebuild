# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )
EGIT_REPO_URI="https://github.com/Azure/msrest-for-python.git"

inherit distutils-r1 git-r3

DESCRIPTION="AutoRest swagger generator Python client runtime"
HOMEPAGE="https://github.com/Azure/msrest-for-python"

LICENSE="MIT"
SLOT="0"
RESTRICT="test"
PROPERTIES="test_network"

DEPEND="dev-python/certifi[${PYTHON_USEDEP}]
	dev-python/isodate[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/requests-oauthlib[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	dev-python/aiodns[${PYTHON_USEDEP}]
	dev-python/aiohttp[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/httpretty[${PYTHON_USEDEP}]
		dev-python/trio[${PYTHON_USEDEP}]
		dev-python/pytest-asyncio[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# AttributeError: module 'trio' has no attribute 'run_sync_in_worker_thread'
	tests/asynctests/test_pipeline.py::test_conf_async_trio_requests
	tests/asynctests/test_universal_http.py::test_conf_async_trio_requests
	# AttributeError: 'TestAuthentication' object has no attribute 'assertDictContainsSubset'
	tests/test_auth.py::TestAuthentication::test_apikey_auth
	tests/test_auth.py::TestAuthentication::test_cs_auth
	tests/test_auth.py::TestAuthentication::test_eventgrid_auth
	tests/test_auth.py::TestAuthentication::test_eventgrid_domain_auth
)
