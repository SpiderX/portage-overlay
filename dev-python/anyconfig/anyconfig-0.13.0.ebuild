# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..12} )

inherit distutils-r1

MY_PN="python-${PN}-RELEASE"
MY_P="${MY_PN}_${PV}"

DESCRIPTION="Generic access to configuration files in any formats"
HOMEPAGE="https://github.com/ssato/python-anyconfig"
SRC_URI="https://github.com/ssato/python-${PN}/archive/RELEASE_${PV}.tar.gz -> ${MY_P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/jinja2[${PYTHON_USEDEP}]
	dev-python/jmespath[${PYTHON_USEDEP}]
	dev-python/jsonschema[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/ruamel-yaml[${PYTHON_USEDEP}]
	dev-python/simplejson[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"

distutils_enable_tests pytest

python_prepare_all() {
	# Remove coverage
	sed -i '/addopts/d' setup.cfg \
		|| die "sed failed for setup.cfg"

	distutils-r1_python_prepare_all
}
