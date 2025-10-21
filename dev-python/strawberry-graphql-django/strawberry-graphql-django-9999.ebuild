# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 git-r3

DESCRIPTION="Strawberry GraphQL Django extension"
HOMEPAGE="https://github.com/strawberry-graphql/strawberry-django"
EGIT_REPO_URI="https://github.com/strawberry-graphql/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/asgiref[${PYTHON_USEDEP}]
	dev-python/lia-web[${PYTHON_USEDEP}]
	dev-python/django[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/django-debug-toolbar[${PYTHON_USEDEP}]
	dev-python/django-model-utils[${PYTHON_USEDEP}]
	dev-python/django-polymorphic[${PYTHON_USEDEP}]
	dev-python/strawberry-graphql[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-db/spatialite
		dev-python/django-choices-field[${PYTHON_USEDEP}]
		=dev-python/django-guardian-2.4.0[${PYTHON_USEDEP}]
		dev-python/django-tree-queries[${PYTHON_USEDEP}]
		dev-python/inline-snapshot[${PYTHON_USEDEP}]
		dev-python/factory-boy[${PYTHON_USEDEP}]
		dev-python/libcst[${PYTHON_USEDEP}]
		dev-python/pytest-codspeed[${PYTHON_USEDEP}]
		dev-python/pytest-emoji[${PYTHON_USEDEP}]
		dev-python/pytest-snapshot[${PYTHON_USEDEP}]
		dev-python/starlette[${PYTHON_USEDEP}]
		dev-python/typer[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# table tests_geosfieldsmodel has no column named point
	tests/queries/test_fields.py::test_geo_data
	tests/mutations/test_mutations.py::test_create_geo
	tests/mutations/test_mutations.py::test_update_geo
)

src_prepare() {
	default

	# remove coverage
	sed -i '/addopts/d' pyproject.toml || die "sed failed"
}
