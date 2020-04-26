# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python{2_7,3_{6..8}} pypy3 )

inherit distutils-r1

DESCRIPTION="A JavaScript minifier written in Python"
HOMEPAGE="https://slimit.readthedocs.io/en/latest"
SRC_URI="https://api.github.com/repos/rspivak/${PN}/tarball/40956e7 -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND=">=dev-python/ply-3.11:=[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

S="${WORKDIR}/rspivak-${PN}-40956e7"

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
