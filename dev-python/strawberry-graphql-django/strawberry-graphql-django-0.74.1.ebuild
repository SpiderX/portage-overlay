# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..13} )

inherit distutils-r1

DESCRIPTION="Strawberry GraphQL Django extension"
HOMEPAGE="https://github.com/strawberry-graphql/strawberry-django"
SRC_URI="https://github.com/strawberry-graphql/strawberry-graphql-django/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/strawberry-django-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/asgiref[${PYTHON_USEDEP}]
	dev-python/cross-web[${PYTHON_USEDEP}]
	dev-python/django[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/django-debug-toolbar[${PYTHON_USEDEP}]
	dev-python/django-model-utils[${PYTHON_USEDEP}]
	dev-python/django-polymorphic[${PYTHON_USEDEP}]
	dev-python/strawberry-graphql[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-db/spatialite
		dev-python/django-choices-field[${PYTHON_USEDEP}]
		dev-python/django-guardian[${PYTHON_USEDEP}]
		dev-python/django-tree-queries[${PYTHON_USEDEP}]
		dev-python/factory-boy[${PYTHON_USEDEP}]
		dev-python/libcst[${PYTHON_USEDEP}]
		dev-python/starlette[${PYTHON_USEDEP}]
		dev-python/typer[${PYTHON_USEDEP}] )"

EPYTEST_PLUGINS=( inline-snapshot pytest-{asyncio,codspeed,django,emoji,mock,snapshot} )
distutils_enable_tests pytest

EPYTEST_IGNORE=(
	# AssertionError
	tests/polymorphism
	tests/node_polymorphism
)

src_prepare() {
	default

	# remove coverage
	sed -i '/addopts/d' pyproject.toml || die "sed failed"
}
