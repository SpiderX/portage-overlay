# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 git-r3 optfeature

DESCRIPTION="Yet another Swagger generator"
HOMEPAGE="https://github.com/axnsan12/drf-yasg"
EGIT_REPO_URI="https://github.com/axnsan12/${PN}.git"

LICENSE="BSD-4"
SLOT="0"
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
		dev-python/swagger-spec-validator[${PYTHON_USEDEP}]
		dev-python/user-agents[${PYTHON_USEDEP}] )"

export DJANGO_SETTINGS_MODULE=testproj.settings.local
export DJANGO_SECRET_KEY="secret"

EPYTEST_XDIST=1
EPYTEST_PLUGINS=( pytest-{django,pythonpath} )
distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# KeyError: 'paths'
	tests/test_schema_views.py::test_paginator_schema
)

EPYTEST_IGNORE=( node_modules )

pkg_postinst() {
	optfeature "integration with djangorestframework-camel-case" dev-python/djangorestframework-camel-case
	optfeature "integration with djangorestframework-recursive" dev-python/djangorestframework-recursive
}
