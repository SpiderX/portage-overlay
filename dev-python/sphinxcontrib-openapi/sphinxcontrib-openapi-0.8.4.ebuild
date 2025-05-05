# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

PN_TEST="OpenAPI-Specification"
PV_TEST="3.1.0"
P_TEST="${PN_TEST}-${PV_TEST}"

DESCRIPTION="Sphinx extension to generate APIs docs from OpenAPI"
HOMEPAGE="https://github.com/sphinx-contrib/openapi"
SRC_URI="https://github.com/sphinx-contrib/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz
	test? ( https://github.com/OAI/${PN_TEST}/archive/${PV_TEST}.tar.gz -> ${P_TEST}.gh.tar.gz )"
S="${WORKDIR}/${P//sphinxcontrib-/}"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/deepmerge[${PYTHON_USEDEP}]
	dev-python/jsonschema[${PYTHON_USEDEP}]
	dev-python/picobox[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/sphinx[${PYTHON_USEDEP}]
	dev-python/sphinx-mdinclude[${PYTHON_USEDEP}]
	dev-python/sphinxcontrib-httpdomain[${PYTHON_USEDEP}]"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]"

PATCHES=( "${FILESDIR}/${PN}"-0.8.4-test.patch )

distutils_enable_tests pytest

export SETUPTOOLS_SCM_PRETEND_VERSION="${PV}"

src_unpack() {
	default

	if use test ; then
		cp -R "${S}"/../"${P_TEST}"/. "${S}"/tests/"${PN_TEST}" \
			|| die "copying of OpenAPI-Specification failed"
	fi
}
