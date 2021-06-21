# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )
EGIT_REPO_URI="https://github.com/glemmaPaul/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Django Taggit Serializer Created for the Django REST Framework"
HOMEPAGE="https://github.com/glemmaPaul/django-taggit-serializer"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

DEPEND="dev-python/django-taggit[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"
RDEPEND="${RDEPEND}
	dev-python/django-rest-framework[${PYTHON_USEDEP}]"
BDEPEND="test? ( $(python_gen_impl_dep sqlite)
		dev-python/django-nose[${PYTHON_USEDEP}] )"

distutils_enable_tests nose

python_test() {
	"${PYTHON}" runtests.py --verbosity 2 || die "tests failed with ${EPYTHON}"
}
