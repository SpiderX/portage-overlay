# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{6..7} )
EGIT_REPO_URI="https://github.com/drkjam/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Network address representation and manipulation library"
HOMEPAGE="https://github.com/drkjam/netaddr"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="cli test"
RESTRICT="!test? ( test )"
REQUIRED_USE="cli? ( || ( $(python_gen_useflags -3) ) )"

RDEPEND="cli? ( $(python_gen_cond_dep 'dev-python/ipython[${PYTHON_USEDEP}]' -3) )"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/pytest[${PYTHON_USEDEP}]
		${RDEPEND} )"

python_test() {
	py.test -v || die "tests failed with ${EPYTHON}"
}
