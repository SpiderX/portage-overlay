# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{4..7}} )
EGIT_REPO_URI="https://github.com/nginxinc/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Fast and reliable NGINX configuration parser"
HOMEPAGE="https://github.com/nginxinc/crossplane"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT=0
KEYWORDS=""
IUSE="test"

BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="dev-python/simplejson[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

python_test() {
	py.test || die "tests fail with ${EPYTHON}"
}
