# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_4,3_5,3_6} )

inherit distutils-r1

DESCRIPTION="Generate random strings in Python"
HOMEPAGE="http://bitbucket.org/leapfrogdevelopment/rstr/overview"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${PN}-${PV}.tar.gz"

LICENSE="BSD"
SLOT=0
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="python_targets_python2_7? (
		dev-python/functools32[python_targets_python2_7]
	)"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/unittest2[${PYTHON_USEDEP}] )"

python_test() {
	"${PYTHON}" -m unittest discover rstr/tests || die "failed testsuite"
}
