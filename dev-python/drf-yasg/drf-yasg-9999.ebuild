# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..8} )
EGIT_REPO_URI="https://github.com/axnsan12/${PN}.git"

inherit distutils-r1 eutils git-r3

DESCRIPTION="Yet another Swagger generator"
HOMEPAGE="https://github.com/axnsan12/drf-yasg"
SRC_URI=""

LICENSE="BSD-4"
SLOT="0"
KEYWORDS=""
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND=">=dev-python/coreapi-2.3.3[${PYTHON_USEDEP}]
	>=dev-python/coreschema-0.0.4[${PYTHON_USEDEP}]
	dev-python/django[${PYTHON_USEDEP}]
	>=dev-python/django-rest-framework-3.7.7[${PYTHON_USEDEP}]
	>=dev-python/inflection-0.3.1[${PYTHON_USEDEP}]
	>=dev-python/ruamel-yaml-0.15.34[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	>=dev-python/uritemplate-3.0.0[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/datadiff[${PYTHON_USEDEP}]
		dev-python/django-cors-headers[${PYTHON_USEDEP}]
		>=dev-python/django-filter-2.0.0[${PYTHON_USEDEP}]
		>=dev-python/django-oauth-toolkit-1.2.0[${PYTHON_USEDEP}]
		dev-python/django-rest-framework-camel-case[${PYTHON_USEDEP}]
		dev-python/django-rest-framework-recursive[${PYTHON_USEDEP}]
		dev-python/dj-database-url[${PYTHON_USEDEP}]
		dev-python/flex[${PYTHON_USEDEP}]
		dev-python/pillow[${PYTHON_USEDEP}]
		dev-python/pygments[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pytest-django[${PYTHON_USEDEP}]
		dev-python/pytest-pythonpath[${PYTHON_USEDEP}]
		dev-python/pytest-xdist[${PYTHON_USEDEP}]
		dev-python/python-user-agents[${PYTHON_USEDEP}]
		dev-python/swagger_spec_validator[${PYTHON_USEDEP}] )"

python_test() {
	pytest -v || die "tests failed with ${EPYTHON}"
}

pkg_postinst() {
	optfeature "integration with djangorestframework-camel-case" dev-python/django-rest-framework-camel-case
	optfeature "integration with djangorestframework-recursive" dev-python/django-rest-framework-recursive
}
