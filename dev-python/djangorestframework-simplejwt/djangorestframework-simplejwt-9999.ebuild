# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 git-r3

DESCRIPTION="JSON Web Token authentication plugin for the Django REST Framework"
HOMEPAGE="https://github.com/jazzband/djangorestframework-simplejwt"
EGIT_REPO_URI="https://github.com/jazzband/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]
	dev-python/djangorestframework[${PYTHON_USEDEP}]
	dev-python/pyjwt[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/cryptography[${PYTHON_USEDEP}]
		dev-python/freezegun[${PYTHON_USEDEP}] )"

EPYTEST_XDIST=1
EPYTEST_PLUGINS=( pytest-django )
distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# flickering - AssertionError: 200 != 401
	tests/test_integration.py::TestTestView::test_expired_token
)
