# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="Google Cloud Bigquery Storage API client library"
HOMEPAGE="https://github.com/googleapis/google-cloud-python"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="dev-python/google-api-core[grpc,${PYTHON_USEDEP}]
	dev-python/google-auth[${PYTHON_USEDEP}]
	dev-python/grpc-google-iam-v1[${PYTHON_USEDEP}]
	dev-python/protobuf[${PYTHON_USEDEP}]
	dev-python/proto-plus[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/fastavro[${PYTHON_USEDEP}]
		dev-python/google-cloud-bigquery[${PYTHON_USEDEP}]
		dev-python/google-cloud-testutils[${PYTHON_USEDEP}]
		dev-python/pandas[${PYTHON_USEDEP}]
		dev-python/pyarrow[${PYTHON_USEDEP}] )"

EPYTEST_PLUGINS=( pytest-asyncio )
distutils_enable_tests pytest

EPYTEST_IGNORE=(
	# google.auth.exceptions.DefaultCredentialsError
	tests/system/reader/test_reader.py
	tests/system/reader/test_reader_dataframe.py
	tests/system/test_writer.py
)

pkg_postinst() {
	optfeature "integration with pandas" dev-python/pandas
	optfeature "integration with pyarrow" dev-python/pyarrow
	optfeature "integration with fastavro" dev-python/fastavro
}
