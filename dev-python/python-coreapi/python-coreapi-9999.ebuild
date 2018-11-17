# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{4..6}} )
EGIT_REPO_URI="https://github.com/core-api/python-client.git"

inherit distutils-r1 git-r3

DESCRIPTION="Python client library for Core API"
HOMEPAGE="https://github.com/core-api/python-client"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="test"

BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="dev-python/python-coreschema[${PYTHON_USEDEP}]
	dev-python/itypes[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/uritemplate[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	test? ( dev-python/coverage[${PYTHON_USEDEP}]
		dev-python/flake8[${PYTHON_USEDEP}] )
		dev-python/pytest[${PYTHON_USEDEP}]"

python_test() {
	./runtests || die "tests failed with ${EPYTHON}"
}
