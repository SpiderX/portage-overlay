# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..12} )
EGIT_REPO_URI="https://github.com/ssato/python-anyconfig.git"

inherit distutils-r1 git-r3

DESCRIPTION="Generic access to configuration files in any formats"
HOMEPAGE="https://github.com/ssato/python-anyconfig"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-python/jinja[${PYTHON_USEDEP}]
	dev-python/jmespath[${PYTHON_USEDEP}]
	dev-python/jsonschema[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/ruamel-yaml[${PYTHON_USEDEP}]
	dev-python/simplejson[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

distutils_enable_tests pytest

python_prepare_all() {
	# Remove coverage
	sed -i '/addopts/d' setup.cfg \
		|| die "sed failed for setup.cfg"

	distutils-r1_python_prepare_all
}
