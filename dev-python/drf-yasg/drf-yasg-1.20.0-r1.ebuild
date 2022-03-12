# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8,9} )

inherit distutils-r1 optfeature

DESCRIPTION="Yet another Swagger generator"
HOMEPAGE="https://github.com/axnsan12/drf-yasg"
SRC_URI="https://github.com/axnsan12/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-4"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+validation"

RDEPEND="dev-python/coreapi[${PYTHON_USEDEP}]
	dev-python/coreschema[${PYTHON_USEDEP}]
	dev-python/django[${PYTHON_USEDEP}]
	dev-python/djangorestframework[${PYTHON_USEDEP}]
	dev-python/inflection[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/ruamel-yaml[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/uritemplate[${PYTHON_USEDEP}]
	validation? ( dev-python/swagger_spec_validator[${PYTHON_USEDEP}] )"
DEPEND="${RDEPEND}"
BDEPEND="test? ( dev-python/datadiff[${PYTHON_USEDEP}]
		dev-python/django-cors-headers[${PYTHON_USEDEP}]
		dev-python/django-fake-model[${PYTHON_USEDEP}]
		dev-python/django-filter[${PYTHON_USEDEP}]
		dev-python/django-oauth-toolkit[${PYTHON_USEDEP}]
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

distutils_enable_tests pytest

pkg_postinst() {
	optfeature "integration with djangorestframework-camel-case" dev-python/django-rest-framework-camel-case
	optfeature "integration with djangorestframework-recursive" dev-python/django-rest-framework-recursive
}
