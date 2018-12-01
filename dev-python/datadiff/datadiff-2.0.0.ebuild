# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{4..7}} )

inherit distutils-r1

DESCRIPTION="A library for diffs of python data structures"
HOMEPAGE="https://datadiff.sourceforge.net/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
# no tests in tarball
RESTRICT="test"

BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
DEPEND="test? ( dev-python/nose[${PYTHON_USEDEP}]
		dev-python/six[${PYTHON_USEDEP}] )"

python_test() {
	nosetests -v || die "tests failed with ${EPYTHON}"
}
