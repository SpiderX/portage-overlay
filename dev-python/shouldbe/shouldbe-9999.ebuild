# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..8} )
EGIT_REPO_URI="https://github.com/directxman12/should_be.git"

inherit distutils-r1 git-r3

DESCRIPTION="A Python Assertions Helper"
HOMEPAGE="https://github.com/directxman12/should_be"
SRC_URI=""

LICENSE="ISC"
SLOT="0"
KEYWORDS=""
IUSE="test"

RDEPEND="dev-python/forbiddenfruit[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

python_test() {
	"${PYTHON}" -m unittest discover -v || die "tests failed with ${EPYTHON}"
}

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -type d -name "tests" -exec rm -rv {} + || die "tests removing failed"
}
