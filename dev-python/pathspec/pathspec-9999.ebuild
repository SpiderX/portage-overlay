# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{5..7}} )
EGIT_REPO_URI="https://github.com/cpburnz/python-path-specification.git"

inherit distutils-r1 git-r3

DESCRIPTION="A utility library for pattern matching of file paths"
HOMEPAGE="https://github.com/cpburnz/python-path-specification"
SRC_URI=""

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS=""
IUSE=""

python_test() {
	"${PYTHON}" -m unittest discover -v || die "tests failed with ${EPYTHON}"
}

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -type d -name "tests" -exec rm -rv {} + || die "tests removing failed"
}
