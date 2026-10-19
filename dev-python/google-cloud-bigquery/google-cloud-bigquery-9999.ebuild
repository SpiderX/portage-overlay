# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 git-r3 optfeature

DESCRIPTION="Google Cloud BigQuery API client library"
HOMEPAGE="https://github.com/googleapis/google-cloud-python"
EGIT_REPO_URI="https://github.com/googleapis/google-cloud-python.git"
S="${WORKDIR}/${P}/packages/${PN}"

LICENSE="Apache-2.0"
SLOT="0"

RDEPEND="dev-python/google-api-core[grpc,${PYTHON_USEDEP}]
	dev-python/google-auth[${PYTHON_USEDEP}]
	dev-python/google-cloud-core[${PYTHON_USEDEP}]
	dev-python/google-resumable-media[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/pyopenssl[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/db-dtypes[${PYTHON_USEDEP}]
		dev-python/google-cloud-bigquery-storage[${PYTHON_USEDEP}]
		dev-python/google-cloud-datacatalog[${PYTHON_USEDEP}]
		dev-python/google-cloud-resource-manager[${PYTHON_USEDEP}]
		dev-python/google-cloud-testutils[${PYTHON_USEDEP}]
		dev-python/ipython[${PYTHON_USEDEP}]
		dev-python/ipywidgets[${PYTHON_USEDEP}]
		dev-python/opentelemetry-instrumentation[${PYTHON_USEDEP}]
		dev-python/opentelemetry-sdk[${PYTHON_USEDEP}]
		dev-python/tqdm[${PYTHON_USEDEP}] )"

EPYTEST_PLUGINS=()
EPYTEST_IGNORE=( tests/system )
distutils_enable_tests pytest

pkg_postinst() {
	optfeature "integration with bigquery_v2" dev-python/proto-plus dev-python/protobuf
	optfeature "integration with bqstorage" dev-python/google-cloud-bigquery-storage \
		dev-python/grpcio dev-python/pyarrow
	optfeature "integration with geopandas" dev-python/shapely #dev-python/geopandas
	optfeature "integration with ipython" dev-python/ipython #dev-python/bigquery-magics
	optfeature "integration with ipywidgets" dev-python/ipykernel dev-python/ipywidgets
	optfeature "integration with matplotlib" dev-python/matplotlib
	optfeature "integration with tqdm" dev-python/tqdm
	optfeature "integration with opentelemetry" dev-python/opentelemetry-api \
		dev-python/opentelemetry-sdk dev-python/opentelemetry-instrumentation
	optfeature "integration with pandas" dev-python/pandas dev-python/grpcio dev-python/pyarrow \
		dev-python/db-dtypes #pandas-gbq
}
