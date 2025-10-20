# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

MY_PN="${PN//google-cloud/python}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Google Cloud Pub/Sub API client library"
HOMEPAGE="https://github.com/googleapis/python-pubsub"
SRC_URI="https://github.com/googleapis/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_P}.gh.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/google-api-core[${PYTHON_USEDEP}]
	dev-python/google-auth[${PYTHON_USEDEP}]
	dev-python/grpcio[${PYTHON_USEDEP}]
	dev-python/grpcio-status[${PYTHON_USEDEP}]
	dev-python/grpc-google-iam-v1[${PYTHON_USEDEP}]
	dev-python/opentelemetry-api[${PYTHON_USEDEP}]
	dev-python/opentelemetry-sdk[${PYTHON_USEDEP}]
	dev-python/protobuf[${PYTHON_USEDEP}]
	dev-python/proto-plus[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/flaky[${PYTHON_USEDEP}] )"

EPYTEST_PLUGINS=( pytest-asyncio )
distutils_enable_tests pytest

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
