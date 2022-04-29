# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )
EGIT_REPO_URI="https://github.com/Azure/msrest-for-python.git"

inherit distutils-r1 git-r3

DESCRIPTION="AutoRest swagger generator Python client runtime"
HOMEPAGE="https://github.com/Azure/msrest-for-python"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
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
		dev-python/trio[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# attribute error
	tests/asynctests/test_pipeline.py::test_conf_async_trio_requests
	tests/asynctests/test_universal_http.py::test_conf_async_trio_requests
)
