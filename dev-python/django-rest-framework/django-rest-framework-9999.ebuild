# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{4..6}} )
EGIT_REPO_URI="https://github.com/encode/${PN}.git"

inherit distutils-r1 eutils git-r3

DESCRIPTION="Django REST framework"
HOMEPAGE="https://django-rest-framework.org/"
SRC_URI=""

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS=""
IUSE="test"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( $(python_gen_impl_dep sqlite)
		dev-python/django-guardian[${PYTHON_USEDEP}]
		dev-python/psycopg:2[${PYTHON_USEDEP}]
		dev-python/pytest-django[${PYTHON_USEDEP}]
		dev-python/python-coreapi[${PYTHON_USEDEP}]
		virtual/python-typing[${PYTHON_USEDEP}] )"

python_test() {
	./runtests.py -v --nolint || die "tests failed with ${EPYTHON}"
}

pkg_postinst() {
	optfeature "integration with Core API" dev-python/python-coreapi
	optfeature "integration with Core API schema generation" dev-python/python-coreschema
	optfeature "integration with filtering backend" dev-python/django-filter
	optfeature "integration with permission backend" dev-python/django-guardian
	optfeature "support for markdown syntax" dev-python/markdown
	optfeature "support for PostgreSQL" dev-python/psycopg:2
}
