# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )
EGIT_REPO_URI="https://github.com/heywbj/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Recursive Serialization for Django REST framework"
HOMEPAGE="https://github.com/heywbj/django-rest-framework-recursive"
SRC_URI=""

LICENSE="ISC"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-python/django-rest-framework[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="test? ( $(python_gen_impl_dep sqlite) )"

# remove incorrectly defined test
PATCHES=( "${FILESDIR}/${PN}"-0.1.2-test.patch )

distutils_enable_tests pytest

python_test() {
	./runtests.py -v || die "tests failed with ${EPYTHON}"
}
