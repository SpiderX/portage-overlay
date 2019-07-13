# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{5..6}} )
EGIT_REPO_URI="https://github.com/marcgibbons/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Swagger UI for Django REST Framework"
HOMEPAGE="https://marcgibbons.com/django-rest-swagger/"
SRC_URI=""

LICENSE="BSD-2"
SLOT="0"
KEYWORDS=""
IUSE="test"

RDEPEND="dev-python/coreapi[${PYTHON_USEDEP}]
	dev-python/django-rest-framework[${PYTHON_USEDEP}]
	dev-python/python-openapi-codec[${PYTHON_USEDEP}]
	dev-python/simplejson[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( $(python_gen_impl_dep sqlite)
		virtual/python-unittest-mock[${PYTHON_USEDEP}] )"

python_test() {
	# no verbose in tests
	./runtests.py || die "tests failed with ${EPYTHON}"
}
