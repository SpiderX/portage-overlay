# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..8} )
EGIT_REPO_URI="https://github.com/python-trio/${MY_PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Sniff out which async library your code is running under"
HOMEPAGE="https://github.com/python-trio/sniffio"
SRC_URI=""

LICENSE="Apache-2.0 MIT"
SLOT="0"
KEYWORDS=""
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="$(python_gen_cond_dep 'dev-python/contextvars[${PYTHON_USEDEP}]' python3_6)"
DEPEND="${RDEPEND}"
BDEPEND="test? ( dev-python/curio[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}] )"

python_test() {
	py.test -v || die "tests failed with ${EPYTHON}"
}

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -type d -name "_tests" -exec rm -rv {} + || die "tests removing failed"
}
