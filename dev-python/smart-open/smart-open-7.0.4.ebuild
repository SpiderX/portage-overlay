# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

MY_PN="${PN//-/_}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Utils for streaming large files"
HOMEPAGE="https://github.com/piskvorky/smart_open"
SRC_URI="https://github.com/piskvorky/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_P}.gh.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/azure-core[${PYTHON_USEDEP}]
	dev-python/azure-common[${PYTHON_USEDEP}]
	dev-python/azure-storage-blob[${PYTHON_USEDEP}]
	dev-python/boto3[${PYTHON_USEDEP}]
	dev-python/google-cloud-storage[${PYTHON_USEDEP}]
	dev-python/paramiko[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/wrapt[${PYTHON_USEDEP}]
	dev-python/zstandard[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/moto[${PYTHON_USEDEP}]
		dev-python/responses[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# connections
	smart_open/tests/test_http.py::HttpTest::test_https_seek_forward
	smart_open/tests/test_http.py::HttpTest::test_seek_from_current
	smart_open/tests/test_http.py::HttpTest::test_seek_from_end
	smart_open/tests/test_http.py::HttpTest::test_seek_from_start
	# compression
	smart_open/tests/test_smart_open.py::SmartOpenHttpTest::test_http_gz
	smart_open/tests/test_smart_open.py::SmartOpenHttpTest::test_http_gz_query
	smart_open/tests/test_smart_open.py::test_s3_gzip_compress_sanity
	smart_open/tests/test_smart_open.py::test_s3_read_explicit
	smart_open/tests/test_smart_open.py::test_s3_write_explicit
	smart_open/tests/test_smart_open.py::test_s3_write_implicit
	smart_open/tests/test_smart_open.py::test_s3_disable_compression
)
