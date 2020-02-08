# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{6..8} pypy3 )
EGIT_REPO_URI="https://github.com/esnme/ultrajson.git"

inherit distutils-r1 git-r3

DESCRIPTION="Ultra fast JSON encoder and decoder for Python"
HOMEPAGE="https://github.com/esnme/ultrajson"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( $(python_gen_cond_dep 'dev-python/unittest2[${PYTHON_USEDEP}]' -2)
		dev-python/pytz[${PYTHON_USEDEP}]
		dev-python/six[${PYTHON_USEDEP}] )"

python_test() {
	"${PYTHON}" -m unittest discover -v tests || die "tests failed with ${EPYTHON}"
}
