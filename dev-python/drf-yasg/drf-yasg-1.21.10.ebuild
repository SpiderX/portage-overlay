# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 optfeature

DESCRIPTION="Yet another Swagger generator"
HOMEPAGE="https://github.com/axnsan12/drf-yasg"
SRC_URI="https://github.com/axnsan12/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD-4"
SLOT="0"
KEYWORDS="~amd64"
IUSE="coreapi +validation"
RESTRICT="test" # no configuration

RDEPEND="dev-python/django[${PYTHON_USEDEP}]
	dev-python/djangorestframework[${PYTHON_USEDEP}]
	dev-python/inflection[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	dev-python/uritemplate[${PYTHON_USEDEP}]
	coreapi? ( dev-python/coreapi[${PYTHON_USEDEP}]
		dev-python/coreschema[${PYTHON_USEDEP}] )
	validation? ( dev-python/swagger-spec-validator[${PYTHON_USEDEP}] )"
DEPEND="${RDEPEND}"
BDEPEND="test? ( dev-python/datadiff[${PYTHON_USEDEP}]
		dev-python/django-cors-headers[${PYTHON_USEDEP}]
		dev-python/django-fake-model[${PYTHON_USEDEP}]
		dev-python/django-filter[${PYTHON_USEDEP}]
		dev-python/django-oauth-toolkit[${PYTHON_USEDEP}]
		dev-python/djangorestframework-camel-case[${PYTHON_USEDEP}]
		dev-python/djangorestframework-recursive[${PYTHON_USEDEP}]
		dev-python/dj-database-url[${PYTHON_USEDEP}]
		dev-python/pillow[${PYTHON_USEDEP}]
		dev-python/pygments[${PYTHON_USEDEP}]
		dev-python/pytest-django[${PYTHON_USEDEP}]
		dev-python/pytest-pythonpath[${PYTHON_USEDEP}]
		dev-python/python-user-agents[${PYTHON_USEDEP}]
		dev-python/swagger-spec-validator[${PYTHON_USEDEP}] )"

EPYTEST_XDIST=1
distutils_enable_tests pytest

pkg_postinst() {
	optfeature "integration with djangorestframework-camel-case" dev-python/djangorestframework-camel-case
	optfeature "integration with djangorestframework-recursive" dev-python/djangorestframework-recursive
}
