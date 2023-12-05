# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10,11} )
EGIT_REPO_URI="https://github.com/RaRe-Technologies/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Utils for streaming large files"
HOMEPAGE="https://github.com/RaRe-Technologies/smart_open"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-python/azure-core[${PYTHON_USEDEP}]
	dev-python/azure-common[${PYTHON_USEDEP}]
	dev-python/azure-storage-blob[${PYTHON_USEDEP}]
	dev-python/boto3[${PYTHON_USEDEP}]
	dev-python/google-cloud-storage[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/moto[${PYTHON_USEDEP}]
		dev-python/paramiko[${PYTHON_USEDEP}]
		dev-python/responses[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# connections
	smart_open/tests/test_http.py::HttpTest::test_https_seek_forward
	smart_open/tests/test_http.py::HttpTest::test_seek_from_current
	smart_open/tests/test_http.py::HttpTest::test_seek_from_end
	smart_open/tests/test_http.py::HttpTest::test_seek_from_start
)
