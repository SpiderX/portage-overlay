# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 edo git-r3

DESCRIPTION="Django Debug Toolbar for GraphiQL IDE"
HOMEPAGE="https://github.com/flavors/django-graphiql-debug-toolbar"
EGIT_REPO_URI="https://github.com/flavors/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]
	dev-python/django-debug-toolbar[${PYTHON_USEDEP}]
	dev-python/graphene-django[${PYTHON_USEDEP}]"

PATCHES=( "${FILESDIR}/${PN}"-0.2.0-compat.patch )

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# AttributeError
	tests/test_middleware.py::DebugToolbarMiddlewareTests::test_query
)

export DJANGO_SETTINGS_MODULE='tests.settings'

src_prepare() {
	default

	# define variable for tests
	edo echo 'STATIC_URL="/static"' >> tests/settings.py
}

python_test() {
	local -x PYTHONPATH=.
	epytest
}
