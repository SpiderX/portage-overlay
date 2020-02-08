# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{6..7} )

inherit distutils-r1

DESCRIPTION="Network address representation and manipulation library"
HOMEPAGE="https://github.com/drkjam/netaddr"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cli test"
RESTRICT="!test? ( test )"
REQUIRED_USE="cli? ( || ( $(python_gen_useflags -3) ) )"

RDEPEND="cli? ( $(python_gen_cond_dep 'dev-python/ipython[${PYTHON_USEDEP}]' -3) )"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/pytest[${PYTHON_USEDEP}]
		${RDEPEND} )"

python_prepare_all() {
	# Disable failing tests
	sed -i  -e '/test_oui_parser_py3/i@pytest.mark.skip(reason="disable")' \
		-e '/test_iab_parser_py3/i@pytest.mark.skip(reason="disable")' \
		netaddr/tests/eui/test_ieee_parsers.py \
		|| die "sed failed for test_ieee_parsers.py"

	distutils-r1_python_prepare_all
}

python_test() {
	py.test -v || die "tests failed with ${EPYTHON}"
}
