# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

MY_PN="python-${PN}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Google GRPC IAM API client library"
HOMEPAGE="https://github.com/googleapis/python-grpc-google-iam-v1"
SRC_URI="https://github.com/googleapis/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # no tests

RDEPEND="dev-python/googleapis-common-protos[${PYTHON_USEDEP}]
	dev-python/grpcio[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/pytest-asyncio[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${MY_P}"

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
