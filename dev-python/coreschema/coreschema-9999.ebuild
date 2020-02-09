# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..8} )
EGIT_REPO_URI="https://github.com/core-api/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Python CoreSchema"
HOMEPAGE="https://github.com/core-api/python-coreschema"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-python/jinja[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

python_test() {
	py.test -v || die "tests failed with ${EPYTHON}"
}
