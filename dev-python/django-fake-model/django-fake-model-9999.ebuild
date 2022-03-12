# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )
EGIT_REPO_URI="https://github.com/erm0l0v/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="A library for creating fake models in the unit tests"
HOMEPAGE="https://github.com/erm0l0v/django-fake-model"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
RESTRICT="test" #fails

RDEPEND="dev-python/django[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="test? ( dev-python/django-nose[${PYTHON_USEDEP}] )"

distutils_enable_tests nose

python_test() {
	"${EPYTHON}" runtests.py || die "tests failed with ${EPYTHON}"
}
