# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..7} )
MY_PN="python-${PN}-RELEASE"
MY_P="${MY_PN}_${PV}"

inherit distutils-r1

DESCRIPTION="Generic access to configuration files in any formats"
HOMEPAGE="https://github.com/ssato/python-anyconfig"
SRC_URI="https://github.com/ssato/python-${PN}/archive/RELEASE_${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-python/jinja[${PYTHON_USEDEP}]
	dev-python/jmespath[${PYTHON_USEDEP}]
	dev-python/jsonschema[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/ruamel-yaml[${PYTHON_USEDEP}]
	dev-python/simplejson[${PYTHON_USEDEP}]
	dev-python/toml[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/mock[${PYTHON_USEDEP}]
		dev-python/nose[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${MY_P}"

python_test() {
	nosetests -v -c pkg/nose.cfg || die "tests failed with ${EPYTHON}"
}
