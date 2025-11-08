# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 git-r3

DESCRIPTION="A python model for Cloud Formation scripts"
HOMEPAGE="https://github.com/Skyscanner/pycfmodel"
EGIT_REPO_URI="https://github.com/Skyscanner/${PN}.git"

LICENSE="Apache-2.0"
SLOT="0"

RDEPEND="dev-python/pydantic[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/httpx[${PYTHON_USEDEP}] )"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

# https://github.com/Skyscanner/pycfmodel/issues/79
EPYTEST_IGNORE=( tests/test_constants.py )

python_prepare_all() {
	# adjust pydantic version
	sed -i '/errors.pydantic.dev/s|2.7|2.11|' tests/test_types.py \
		tests/resources/test_s3_bucket.py \
		tests/resources/test_opensearch_domain.py \
		tests/resources/test_es_domain.py || die "sed failed for tests"

	distutils-r1_python_prepare_all
}
