# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Google Cloud Resource Manager API client library"
HOMEPAGE="https://github.com/googleapis/google-cloud-python"
EGIT_REPO_URI="https://github.com/googleapis/google-cloud-python.git"
S="${WORKDIR}/${P}/packages/${PN}"

LICENSE="Apache-2.0"
SLOT="0"

RDEPEND="dev-python/google-api-core[grpc,${PYTHON_USEDEP}]
	dev-python/google-auth[${PYTHON_USEDEP}]
	dev-python/grpc-google-iam-v1[${PYTHON_USEDEP}]
	dev-python/protobuf[${PYTHON_USEDEP}]
	dev-python/proto-plus[${PYTHON_USEDEP}]"

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
