# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Sane and flexible OpenAPI 3 schema generation for Django REST framework"
HOMEPAGE="https://github.com/tfranzel/drf-spectacular"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]
	dev-python/djangorestframework[${PYTHON_USEDEP}]
	dev-python/inflection[${PYTHON_USEDEP}]
	dev-python/jsonschema[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/uritemplate[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/django-filter[${PYTHON_USEDEP}]
		dev-python/django-oauth-toolkit[${PYTHON_USEDEP}]
		dev-python/django-rest-knox[${PYTHON_USEDEP}]
		dev-python/djangorestframework-camel-case[${PYTHON_USEDEP}]
		dev-python/djangorestframework-dataclasses[${PYTHON_USEDEP}]
		dev-python/djangorestframework-gis[${PYTHON_USEDEP}]
		dev-python/djangorestframework-recursive[${PYTHON_USEDEP}]
		dev-python/djangorestframework-simplejwt[${PYTHON_USEDEP}]
		dev-python/drf-nested-routers[${PYTHON_USEDEP}]
		dev-python/drf-spectacular-sidecar[${PYTHON_USEDEP}]
		dev-python/psycopg:2[${PYTHON_USEDEP}]
		sci-libs/gdal
		sci-libs/geos )"

PATCHES=( "${FILESDIR}/${PN}"-0.28.0-drf-auth.patch )

EPYTEST_PLUGINS=( pytest-django )
distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# AssertionError
	tests/test_regressions.py::test_model_choice_display_method_on_readonly
	tests/contrib/test_rest_polymorphic.py::test_rest_polymorphic
	tests/contrib/test_rest_polymorphic.py::test_rest_polymorphic_split_request_with_ro_serializer
	tests/test_callbacks.py::test_callbacks
	tests/test_callbacks.py::test_callbacks_split_request
	tests/test_i18n.py::test_i18n_strings
)
