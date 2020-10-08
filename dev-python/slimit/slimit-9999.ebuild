# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{6..8} pypy3 )
EGIT_REPO_URI="https://github.com/rspivak/slimit.git"

inherit distutils-r1 git-r3

DESCRIPTION="A JavaScript minifier written in Python"
HOMEPAGE="https://slimit.readthedocs.io/en/latest"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="test"

RDEPEND=">=dev-python/ply-3.11:=[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

src_prepare() {
	default

	rm src/slimit/tests/test_lexer.py || die "test remove failed"
}

python_test() {
	"${EPYTHON}" -m unittest discover -v src/slimit \
		|| die "tests failed with ${EPYTHON}"
}

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -type d -name "tests" -exec rm -rv {} + || die "tests removing failed"
}
