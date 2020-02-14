# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..7} )

inherit distutils-r1 eutils

PN_TEST="OpenAPI-Specification"
PV_TEST="3.0.2"
P_TEST="${PN_TEST}-${PV_TEST}"

DESCRIPTION="Sphinx extension to generate APIs docs from OpenAPI"
HOMEPAGE="https://github.com/ikalnytskyi/sphinxcontrib-openapi"
SRC_URI="https://github.com/ikalnytskyi/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
	test? ( https://github.com/OAI/${PN_TEST}/archive/${PV_TEST}.tar.gz -> ${P_TEST}.tar.gz )"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND=">=dev-python/jsonschema-2.5.1[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/sphinx[${PYTHON_USEDEP}]
	dev-python/sphinxcontrib-httpdomain[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/setuptools_scm[${PYTHON_USEDEP}]
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${P//sphinxcontrib-/}"

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
		-e "/use_scm_version/s/True/False/" \
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

pkg_postinst() {
	optfeature "support CommonMark in spec" dev-python/m2r
}
