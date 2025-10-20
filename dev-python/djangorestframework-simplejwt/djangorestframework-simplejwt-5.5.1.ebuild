# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="JSON Web Token authentication plugin for the Django REST Framework"
HOMEPAGE="https://github.com/jazzband/djangorestframework-simplejwt"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]
	dev-python/djangorestframework[${PYTHON_USEDEP}]
	dev-python/pyjwt[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/cryptography[${PYTHON_USEDEP}]
		dev-python/freezegun[${PYTHON_USEDEP}] )"

EPYTEST_XDIST=1
EPYTEST_PLUGINS=( pytest-{django,xdist} )
# flickering - tests/test_integration.py::TestTestView::test_expired_token
distutils_enable_tests pytest
