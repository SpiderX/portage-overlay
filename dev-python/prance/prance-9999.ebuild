# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )
EGIT_REPO_URI="https://github.com/jfinkhaeuser/${PN}.git"

inherit distutils-r1 git-r3 optfeature

DESCRIPTION="Resolving Swagger/OpenAPI 2.0 and 3.0 Parser"
HOMEPAGE="https://github.com/jfinkhaeuser/prance"
SRC_URI=""

LICENSE="Apache-2.0 MIT"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-python/chardet[${PYTHON_USEDEP}]
	dev-python/ruamel-yaml[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/semver[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/openapi-spec-validator[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

python_prepare_all() {
	# disable pytest options
	sed -i '/addopts/d' setup.cfg || die "sed failed for setup.cfg"

	distutils-r1_python_prepare_all
}

python_test() {
	py.test -v -m "not requires_network" || die "tests failed with ${EPYTHON}"
}

pkg_postinst() {
	optfeature "integration with icu" dev-python/pyicu
	optfeature "integration with swagger" dev-python/swagger_spec_validator
	optfeature "integration with openapi" dev-python/openapi-spec-validator
	optfeature "integration with swagger validator" dev-python/flex
	optfeature "command line client" dev-python/click
}
