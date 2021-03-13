# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )
EGIT_REPO_URI="https://github.com/dcramer/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="A simple library for mocking certain Django behavior"
HOMEPAGE="https://github.com/dcramer/mock-django"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-python/django[${PYTHON_USEDEP}]
	dev-python/mock[${PYTHON_USEDEP}]"

distutils_enable_tests nose

python_test() {
	"${PYTHON}" runtests.py -v || die "tests failed with ${EPYTHON}"
}
