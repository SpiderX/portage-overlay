# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )
EGIT_REPO_URI="https://github.com/python-trio/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Sniff out which async library your code is running under"
HOMEPAGE="https://github.com/python-trio/sniffio"
SRC_URI=""

LICENSE="Apache-2.0 MIT"
SLOT="0"
KEYWORDS=""

BDEPEND="test? ( dev-python/curio[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

python_test() {
	py.test -W error -ra -v --pyargs sniffio || die "tests failed with ${EPYTHON}"
}

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -type d -name "_tests" -exec rm -rv {} + || die "tests removing failed"
}
