# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 optfeature

MY_PN="${PN//google-cloud/python}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Google Cloud Spanner API client library"
HOMEPAGE="https://github.com/googleapis/python-spanner"
SRC_URI="https://github.com/googleapis/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_P}.gh.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/google-api-core[${PYTHON_USEDEP}]
	dev-python/google-cloud-core[${PYTHON_USEDEP}]
	dev-python/grpc-google-iam-v1[${PYTHON_USEDEP}]
	dev-python/grpc-interceptor[${PYTHON_USEDEP}]
	dev-python/protobuf[${PYTHON_USEDEP}]
	dev-python/proto-plus[${PYTHON_USEDEP}]
	dev-python/sqlparse[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/google-cloud-monitoring[${PYTHON_USEDEP}]
		dev-python/mmh3[${PYTHON_USEDEP}] )"

EPYTEST_PLUGINS=( pytest-{asyncio,snapshot} )
distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# AssertionError
	tests/mockserver_tests/test_request_id_header.py::TestRequestIDHeader::test_snapshot_read_concurrent
)

EPYTEST_IGNORE=(
	# google.auth.exceptions.DefaultCredentialsError
	tests/system/test_backup_api.py
	tests/system/test_database_api.py
	tests/system/test_dbapi.py
	tests/system/test_instance_api.py
	tests/system/test_session_api.py
	tests/system/test_streaming_chunking.py
	tests/system/test_table_api.py
)

pkg_postinst() {
	optfeature "integration with tracing" dev-python/opentelemetry-api dev-python/opentelemetry-sdk \
		dev-python/opentelemetry-semantic-conventions dev-python/opentelemetry-resourcedetector-gcp \
		dev-python/google-cloud-monitoring dev-python/mmh3
	optfeature "integration with libcst" dev-python/libcst
}

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
