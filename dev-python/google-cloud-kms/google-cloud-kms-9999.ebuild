# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10,11} )
EGIT_REPO_URI="https://github.com/googleapis/python-kms.git"

inherit distutils-r1 git-r3

DESCRIPTION="Google Cloud KMS API client library"
HOMEPAGE="https://github.com/googleapis/python-kms"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-python/google-cloud-iam[${PYTHON_USEDEP}]
	dev-python/grpcio[${PYTHON_USEDEP}]
	dev-python/grpc-google-iam-v1[${PYTHON_USEDEP}]
	dev-python/proto-plus[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/pytest-asyncio[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# need valid PROJECT_ID
	tests/system/test_system.py::TestKeyManagementServiceClient::test_list_global_key_rings
)

python_compile() {
	distutils-r1_python_compile
	find "${BUILD_DIR}" -name '*.pth' -delete || die
}

src_test() {
	rm -r google || die "rm failed"
	distutils-r1_src_test
}

python_test() {
	distutils_write_namespace google
	epytest -v tests || die "tests failed with ${EPYTHON}"
}
