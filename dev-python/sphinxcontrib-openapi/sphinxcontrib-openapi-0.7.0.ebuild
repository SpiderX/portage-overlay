# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

PN_TEST="OpenAPI-Specification"
PV_TEST="3.1.0"
P_TEST="${PN_TEST}-${PV_TEST}"

DESCRIPTION="Sphinx extension to generate APIs docs from OpenAPI"
HOMEPAGE="https://github.com/sphinx-contrib/openapi"
SRC_URI="https://github.com/sphinx-contrib/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
	test? ( https://github.com/OAI/${PN_TEST}/archive/${PV_TEST}.tar.gz -> ${P_TEST}.tar.gz )"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/jsonschema-2.5.1[${PYTHON_USEDEP}]
	dev-python/m2r[${PYTHON_USEDEP}]
	dev-python/namespace-sphinxcontrib[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/responses[${PYTHON_USEDEP}]
	dev-python/sphinx[${PYTHON_USEDEP}]
	dev-python/sphinxcontrib-httpdomain[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/setuptools_scm[${PYTHON_USEDEP}]"

S="${WORKDIR}/${P//sphinxcontrib-/}"

distutils_enable_tests pytest

src_unpack() {
	default

	if use test ; then
		cp -R "${S}"/../"${P_TEST}"/. "${S}"/tests/"${PN_TEST}" \
			|| die "copying of OpenAPI-Specification failed"
	fi
}

python_prepare_all() {
	# setuptools is unable to detect version
	sed -i -e "/setup(/a\\    version='${PV}'," \
		-e '/use_scm_version/s/{"root": here}/False/' \
		setup.py || die "sed failed for setup.py"

	distutils-r1_python_prepare_all
}

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -name '*.pth' -delete || die "removing of *.pth failed"
}
