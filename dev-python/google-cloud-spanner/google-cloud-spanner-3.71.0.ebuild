# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="Google Cloud Spanner API client library"
HOMEPAGE="https://github.com/googleapis/google-cloud-python"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="dev-python/google-api-core[grpc,${PYTHON_USEDEP}]
	dev-python/google-auth[${PYTHON_USEDEP}]
	dev-python/google-cloud-core[${PYTHON_USEDEP}]
	dev-python/google-cloud-monitoring[${PYTHON_USEDEP}]
	dev-python/grpc-google-iam-v1[${PYTHON_USEDEP}]
	dev-python/grpc-interceptor[${PYTHON_USEDEP}]
	dev-python/mmh3[${PYTHON_USEDEP}]
	dev-python/opentelemetry-api[${PYTHON_USEDEP}]
	dev-python/opentelemetry-sdk[${PYTHON_USEDEP}]
	dev-python/opentelemetry-semantic-conventions[${PYTHON_USEDEP}]
	dev-python/opentelemetry-resourcedetector-gcp[${PYTHON_USEDEP}]
	dev-python/protobuf[${PYTHON_USEDEP}]
	dev-python/proto-plus[${PYTHON_USEDEP}]
	dev-python/sqlparse[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/google-cloud-testutils[${PYTHON_USEDEP}] )"

PATCHES=( "${FILESDIR}/${PN}"-3.71.0-lock-release.patch
	"${FILESDIR}/${PN}"-3.71.0-tests-env-leak.patch )

EPYTEST_XDIST=1
EPYTEST_PLUGINS=( pytest-asyncio )
distutils_enable_tests pytest

python_test() {
	epytest tests/unit tests/mockserver_tests
}

pkg_postinst() {
	optfeature "integration with libcst" dev-python/libcst
}
