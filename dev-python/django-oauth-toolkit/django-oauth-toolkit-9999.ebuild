# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{4..6} )
EGIT_REPO_URI="https://github.com/jazzband/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="OAuth2 Provider for Django"
HOMEPAGE="https://github.com/jazzband/django-oauth-toolkit"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="test"

RDEPEND=">=dev-python/django-2[${PYTHON_USEDEP}]
	dev-python/oauthlib[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( $(python_gen_impl_dep sqlite)
		dev-python/django-rest-framework[${PYTHON_USEDEP}]
		dev-python/pytest-django[${PYTHON_USEDEP}]
		virtual/python-unittest-mock[${PYTHON_USEDEP}] ) "

python_test() {
	DJANGO_SETTINGS_MODULE=tests.settings PYTHONPATH=. \
		py.test -v || die "tests failed with ${EPYTHON}"
}
