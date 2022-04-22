# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )
EGIT_REPO_URI="https://github.com/marcgibbons/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Swagger UI for Django REST Framework"
HOMEPAGE="https://marcgibbons.com/django-rest-swagger/"
SRC_URI=""

LICENSE="BSD-2"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-python/coreapi[${PYTHON_USEDEP}]
	dev-python/djangorestframework[${PYTHON_USEDEP}]
	dev-python/python-openapi-codec[${PYTHON_USEDEP}]
	dev-python/simplejson[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

distutils_enable_tests pytest

python_test() {
	DJANGO_SETTINGS_MODULE=tests.settings PYTHONPATH=. epytest \
		|| die "tests failed with ${EPYTHON}"
}
