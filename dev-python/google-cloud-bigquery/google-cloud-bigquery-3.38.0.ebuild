# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 optfeature

MY_PN="${PN//google-cloud/python}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Google Cloud BigQuery API client library"
HOMEPAGE="https://github.com/googleapis/python-bigquery"
SRC_URI="https://github.com/googleapis/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_P}.gh.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/google-api-core[grpc,${PYTHON_USEDEP}]
	dev-python/google-auth[${PYTHON_USEDEP}]
	dev-python/google-cloud-core[${PYTHON_USEDEP}]
	dev-python/google-resumable-media
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/db-dtypes[${PYTHON_USEDEP}]
		dev-python/google-cloud-bigquery-storage[${PYTHON_USEDEP}]
		dev-python/google-cloud-datacatalog[${PYTHON_USEDEP}]
		dev-python/google-cloud-resource-manager[${PYTHON_USEDEP}]
		dev-python/ipython[${PYTHON_USEDEP}]
		dev-python/tqdm[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

EPYTEST_IGNORE=(
	# google.auth.exceptions.DefaultCredentialsError
	tests/system/test_arrow.py
	tests/system/test_client.py
	tests/system/test_job_retry.py
	tests/system/test_list_rows.py
	tests/system/test_query.py
	tests/system/test_structs.py
	tests/system/test_pandas.py
)

pkg_postinst() {
	optfeature "integration with bigquery_v2" dev-python/proto-plus dev-python/protobuf
	optfeature "integration with bqstorage" dev-python/google-cloud-bigquery-storage \
		dev-python/grpcio dev-python/pyarrow
	optfeature "integration with ipywidgets" dev-python/ipykernel dev-python/ipywidgets
	optfeature "integration with matplotlib" dev-python/matplotlib
	optfeature "integration with tqdm" dev-python/tqdm
	optfeature "integration with opentelemetry" dev-python/opentelemetry-api \
		dev-python/opentelemetry-sdk dev-python/opentelemetry-instrumentation
	optfeature "integration with pandas" dev-python/pandas dev-python/grpcio dev-python/pyarrow \
		dev-python/db-dtypes #pandas-gbq
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
