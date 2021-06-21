# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=pyproject.toml
PYTHON_COMPAT=( python3_{8..10} )
EGIT_REPO_URI="https://github.com/OAI/OpenAPI-Specification.git"
EGIT_CHECKOUT_DIR="${WORKDIR}/${P}/tests/OpenAPI-Specification"

inherit distutils-r1 git-r3 optfeature

DESCRIPTION="Resolving Swagger/OpenAPI 2.0 and 3.0 Parser"
HOMEPAGE="https://github.com/jfinkhaeuser/prance"
SRC_URI="https://github.com/jfinkhaeuser/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/chardet[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/semver[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/openapi-spec-validator[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

src_unpack() {
	default
	use test && git-r3_src_unpack
}

python_prepare_all() {
	# scm is unable to detect version
	echo -e "version = '${PV}'\nversion_tuple = ($(ver_cut 0-1), $(ver_cut 2), $(ver_cut 3-))" > prance/_version.py \
		|| die "echo failed for _version.py"
	sed -i  -e '/requires/s/, "setuptools_scm\[toml\]>6"//' pyproject.toml \
		-e '/tool.setuptools_scm/,+1d' \
		|| die "sed failed for pyproject.toml"
	# Disable pytest options
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
