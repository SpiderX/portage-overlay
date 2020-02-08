# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{6..8} )
EGIT_REPO_URI="https://github.com/codeinthehole/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Simple Python URL class"
HOMEPAGE="https://github.com/codeinthehole/purl"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"

python_test() {
	nosetests -v || die "tests failed with ${EPYTHON}"
}
