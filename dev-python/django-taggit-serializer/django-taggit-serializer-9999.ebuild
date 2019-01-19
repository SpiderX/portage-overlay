# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{4..6}} )
EGIT_REPO_URI="https://github.com/glemmaPaul/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Django Taggit Serializer Created for the Django REST Framework"
HOMEPAGE="https://github.com/glemmaPaul/django-taggit-serializer"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="test"

RDEPEND="dev-python/django-rest-framework[${PYTHON_USEDEP}]
	dev-python/django-taggit[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( $(python_gen_impl_dep sqlite)
		dev-python/django-nose[${PYTHON_USEDEP}] )"

python_test() {
	"${PYTHON}" runtests.py --verbosity 2 || die "tests failed with ${EPYTHON}"
}
