# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..7} )
EGIT_REPO_URI="https://github.com/ssato/python-anyconfig.git"

inherit distutils-r1 git-r3

DESCRIPTION="Generic access to configuration files in any formats"
HOMEPAGE="https://github.com/ssato/python-anyconfig"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
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

python_test() {
	nosetests -v -c pkg/nose.cfg || die "tests failed with ${EPYTHON}"
}
