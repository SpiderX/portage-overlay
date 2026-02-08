# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12,13} )

inherit distutils-r1 git-r3 optfeature

DESCRIPTION="Ready-to-go SQLAlchemy concoctions"
HOMEPAGE="https://github.com/litestar-org/advanced-alchemy"
EGIT_REPO_URI="https://github.com/litestar-org/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/alembic[${PYTHON_USEDEP}]
	dev-python/greenlet[${PYTHON_USEDEP}]
	dev-python/sqlalchemy[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/attrs[${PYTHON_USEDEP}]
		dev-python/asgi-lifespan[${PYTHON_USEDEP}]
		dev-python/cattrs[${PYTHON_USEDEP}]
		dev-python/click[${PYTHON_USEDEP}]
		dev-python/dishka[${PYTHON_USEDEP}]
		dev-python/fsspec[${PYTHON_USEDEP}]
		dev-python/google-cloud-spanner[${PYTHON_USEDEP}]
		dev-python/mysql-connector-python[${PYTHON_USEDEP}]
		dev-python/passlib[${PYTHON_USEDEP}]
		dev-python/psycopg:0[${PYTHON_USEDEP}]
		dev-python/oracledb[${PYTHON_USEDEP}]
		dev-python/pydantic[${PYTHON_USEDEP}]
		dev-python/pymssql[${PYTHON_USEDEP}]
		dev-python/rich-click[${PYTHON_USEDEP}]
		dev-python/sanic[${PYTHON_USEDEP}]
		dev-python/sanic-ext[${PYTHON_USEDEP}]
		dev-python/time-machine[${PYTHON_USEDEP}]
		dev-python/uuid-utils[${PYTHON_USEDEP}] )"

EPYTEST_PLUGINS=( pytest-{asyncio,click,databases,lazy-fixtures,mock,xdist} )
distutils_enable_tests pytest

EPYTEST_IGNORE=( tests/integration tests/unit/test_service_to_model_flow.py )
EPYTEST_DESELECT=(
	# ValueError
	tests/unit/test_repository.py::test_model_from_dict_includes_relationship_attributes
	# sqlalchemy.exc.InvalidRequestError
	tests/unit/test_repository.py::test_model_from_dict_backward_compatibility
	tests/unit/test_repository.py::test_model_from_dict_ignores_unknown_attributes
	tests/unit/test_repository.py::test_model_from_dict_empty_relationship
	tests/unit/test_repository.py::test_update_many_data_conversion_handles_mixed_types
)

pkg_postinst() {
	optfeature "integration with argon2" dev-python/argon2-cffi
	optfeature "integration with cli"  dev-python/rich-click
	optfeature "integration with fastapi" dev-python/fastapi dev-python/starlette
	optfeature "integration with flask" dev-python/flask-sqlalchemy dev-python/flask
	optfeature "integration with fsspec" dev-python/fsspec
	optfeature "integration with litestar" dev-python/litestar
	optfeature "integration with oracle" dev-python/oracledb
	optfeature "integration with passlib" dev-python/passlib
	optfeature "integration with postgres" dev-python/asyncpg dev-python/psycopg:3
	optfeature "integration with sanic" dev-python/sanic dev-python/sanic-ext dev-python/sanic-testing
	optfeature "integration with sqlite" dev-python/aiosqlite
	optfeature "integration with uuid" dev-python/uuid-utils
}
