# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="Authentication and Registration in Django Rest Framework"
HOMEPAGE="https://github.com/iMerica/dj-rest-auth"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]
	dev-python/djangorestframework[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/django-allauth[${PYTHON_USEDEP}]
		dev-python/djangorestframework-simplejwt[${PYTHON_USEDEP}]
		dev-python/responses[${PYTHON_USEDEP}] )"

EPYTEST_PLUGINS=( pytest-django )
distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# AssertionError
	dj_rest_auth/tests/test_api.py::APIBasicTests::test_blacklisting
	dj_rest_auth/tests/test_api.py::APIBasicTests::test_custom_jwt_claims
	dj_rest_auth/tests/test_api.py::APIBasicTests::test_custom_jwt_claims_cookie_w_authentication
)

EPYTEST_IGNORE=(
	# https://github.com/iMerica/dj-rest-auth/pull/681
	dj_rest_auth/tests/test_social.py
)

export DJANGO_SETTINGS_MODULE=dj_rest_auth.tests.settings

python_test() {
	local -x PYTHONPATH=dj_rest_auth
	epytest
}

pkg_postinst() {
	optfeature "integration with-social" dev-python/django-allauth
}
