# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 git-r3 optfeature

DESCRIPTION="Google Cloud Storage API client library"
HOMEPAGE="https://github.com/googleapis/google-cloud-python"
EGIT_REPO_URI="https://github.com/googleapis/google-cloud-python.git"
S="${WORKDIR}/${P}/packages/${PN}"

LICENSE="Apache-2.0"
SLOT="0"

RDEPEND="dev-python/google-auth[${PYTHON_USEDEP}]
	dev-python/google-api-core[${PYTHON_USEDEP}]
	dev-python/google-cloud-core[${PYTHON_USEDEP}]
	dev-python/google-crc32c[${PYTHON_USEDEP}]
	dev-python/protobuf[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/google-cloud-iam[${PYTHON_USEDEP}]
		dev-python/google-cloud-kms[${PYTHON_USEDEP}]
		dev-python/google-cloud-pubsub[${PYTHON_USEDEP}]
		dev-python/google-cloud-testutils[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/opentelemetry-sdk[${PYTHON_USEDEP}] )"

EPYTEST_XDIST=1
EPYTEST_PLUGINS=( pytest-asyncio )
distutils_enable_tests pytest

python_test() {
	epytest tests/unit
}

pkg_postinst() {
	optfeature "integration with grpc" dev-python/grpcio dev-python/grpcio-status \
		dev-python/grpc-google-iam-v1 dev-python/proto-plus dev-python/protobuf
	optfeature "integration with protobuf" dev-python/protobuf
	optfeature "integration with tracing" dev-python/opentelemetry-api
}
