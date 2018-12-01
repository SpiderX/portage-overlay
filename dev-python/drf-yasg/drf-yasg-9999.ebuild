# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{4..6}} )
EGIT_REPO_URI="https://github.com/axnsan12/${PN}.git"

inherit distutils-r1 eutils git-r3

DESCRIPTION="Yet another Swagger generator"
HOMEPAGE="https://github.com/axnsan12/drf-yasg"
SRC_URI=""

LICENSE="BSD-4"
SLOT="0"
KEYWORDS=""
IUSE="test"

BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="dev-python/django[${PYTHON_USEDEP}]
	>=dev-python/django-rest-framework-3.7.7[${PYTHON_USEDEP}]
	>=dev-python/inflection-0.3.1[${PYTHON_USEDEP}]
	>=dev-python/python-coreapi-2.3.3[${PYTHON_USEDEP}]
	>=dev-python/python-coreschema-0.0.4[${PYTHON_USEDEP}]
	>=dev-python/ruamel-yaml-0.15.34[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	>=dev-python/uritemplate-3.0.0[${PYTHON_USEDEP}]
	virtual/python-futures[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	test? ( dev-python/datadiff[${PYTHON_USEDEP}]
		dev-python/django-cors-headers[${PYTHON_USEDEP}]
		dev-python/django-rest-framework-camel-case[${PYTHON_USEDEP}]
		dev-python/django-rest-framework-recursive[${PYTHON_USEDEP}]
		dev-python/dj-database-url[${PYTHON_USEDEP}]
		dev-python/pillow[${PYTHON_USEDEP}]
		dev-python/pygments[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pytest-django[${PYTHON_USEDEP}]
		dev-python/pytest-pythonpath[${PYTHON_USEDEP}]
		dev-python/pytest-xdist[${PYTHON_USEDEP}]
		dev-python/python-user-agents[${PYTHON_USEDEP}]
		$(python_gen_cond_dep '<dev-python/django-filter-2.0.0[${PYTHON_USEDEP}]' python2_7)
		$(python_gen_cond_dep '>=dev-python/django-filter-2.0.0[${PYTHON_USEDEP}]' python3_4 python3_5 python3_6) )"

python_test() {
	pytest -v || die "tests failed with ${EPYTHON}"
}

pkg_postinst() {
	optfeature "integration with djangorestframework-camel-case" dev-python/django-rest-framework-camel-case
	optfeature "integration with djangorestframework-recursive" dev-python/django-rest-framework-recursive
}
