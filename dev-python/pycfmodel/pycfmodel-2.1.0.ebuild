# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="A python model for Cloud Formation scripts"
HOMEPAGE="https://github.com/Skyscanner/pycfmodel"
SRC_URI="https://github.com/Skyscanner/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-python/pydantic[${PYTHON_USEDEP}]"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]
	test? ( dev-python/httpx[${PYTHON_USEDEP}] )"

export SETUPTOOLS_SCM_PRETEND_VERSION="${PV}"

EPYTEST_PLUGINS=( pytest-repeat )
distutils_enable_tests pytest

EPYTEST_DESELECT=( tests/test_constants.py::test_cloudformation_actions )

python_prepare_all() {
	# adjust pydantic version
	sed -i '/errors.pydantic.dev/s|2.7|2.12|' tests/test_types.py \
		tests/resources/test_s3_bucket.py \
		tests/resources/test_opensearch_domain.py \
		tests/resources/test_es_domain.py || die "sed failed for tests"

	distutils-r1_python_prepare_all
}
