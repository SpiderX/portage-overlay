# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..7} )
EGIT_REPO_URI="https://git.code.sf.net/p/${PN}/code"

inherit distutils-r1 git-r3

DESCRIPTION="A library for diffs of python data structures"
HOMEPAGE="https://datadiff.sourceforge.net"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="test"

BDEPEND="test? ( dev-python/nose[${PYTHON_USEDEP}]
		dev-python/six[${PYTHON_USEDEP}] )"

PATCHES=( "${FILESDIR}/${P}"-py3-test.patch )

python_test() {
	nosetests -v || die "tests failed with ${EPYTHON}"
}
