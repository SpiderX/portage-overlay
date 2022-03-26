# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="OpenAPI Spec validator"
HOMEPAGE="https://github.com/p1c2u/openapi-spec-validator"
SRC_URI="https://github.com/p1c2u/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-python/jsonschema[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="test? ( dev-python/openapi-schema-validator[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

python_prepare_all() {

	# fix QA
	sed -i  -e 's/long-description-content-type/long_description_content_type/' \
		-e '/addopts/d' \
		setup.cfg || die "sed failed"

	distutils-r1_python_prepare_all
}
