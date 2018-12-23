# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{4..6}} )

inherit distutils-r1

DESCRIPTION="Sphinx extension to generate APIs docs from OpenAPI"
HOMEPAGE="https://github.com/ikalnytskyi/sphinxcontrib-openapi"
SRC_URI="https://github.com/ikalnytskyi/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=dev-python/jsonschema-2.5.1[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/sphinx[${PYTHON_USEDEP}]
	dev-python/sphinxcontrib-httpdomain[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/setuptools_scm[${PYTHON_USEDEP}]
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${P//sphinxcontrib-/}"

python_prepare_all() {
	# setuptools is unable to detect version, relax requirement
	sed -i -e "/setup(/a\\    version='${PV}'," \
		-e "/use_scm_version/s/True/False/" \
		-e "/sphinxcontrib-httpdomain/s/1.5.0/1.4.0/" \
		setup.py || die "sed failed for setup.py"

	distutils-r1_python_prepare_all
}

python_test() {
	py.test -v || die "tests failed with ${EPYTHON}"
}

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -name '*.pth' -delete || die "removing of *.pth failed"
}
