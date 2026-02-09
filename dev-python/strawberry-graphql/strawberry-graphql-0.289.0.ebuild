# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..13} )

inherit distutils-r1 optfeature

DESCRIPTION="A library for creating GraphQL APIs"
HOMEPAGE="https://github.com/strawberry-graphql/strawberry"
SRC_URI="https://github.com/strawberry-graphql/strawberry/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/strawberry-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/cross-web[${PYTHON_USEDEP}]
	dev-python/graphql-core[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/aiohttp[${PYTHON_USEDEP}]
		dev-python/channels[${PYTHON_USEDEP}]
		dev-python/email-validator[${PYTHON_USEDEP}]
		dev-python/libcst[${PYTHON_USEDEP}]
		dev-python/opentelemetry-api[${PYTHON_USEDEP}]
		dev-python/pyinstrument[${PYTHON_USEDEP}]
		dev-python/quart[${PYTHON_USEDEP}]
		dev-python/sanic[${PYTHON_USEDEP}]
		dev-python/starlette[${PYTHON_USEDEP}]
		dev-python/typer[${PYTHON_USEDEP}]
		dev-python/uvicorn[${PYTHON_USEDEP}] )"

export DJANGO_SETTINGS_MODULE='tests.django.django_settings'

EPYTEST_PLUGINS=( inline-snapshot pytest-{asyncio,codspeed,django,emoji,mock,snapshot} )
distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# failure
	tests/schema/test_lazy/test_lazy_generic.py::test_lazy_types_loaded_from_same_module
	# AssertionError
	tests/http/incremental/test_multipart_subscription.py::test_multipart_subscription
)

EPYTEST_IGNORE=( tests/benchmarks )

pkg_postinst() {
	optfeature "integration with aiohttp" dev-python/aiohttp
	optfeature "integration with asgi"  dev-python/starlette dev-python/python-multipart
	optfeature "integration with channels" dev-python/channels dev-python/asgiref
	optfeature "integration with cli" dev-python/typer dev-python/pygments dev-python/rich \
		dev-python/libcst dev-python/starlette dev-python/uvicorn dev-python/websockets \
		dev-python/python-multipart
	optfeature "integration with debug" dev-python/rich dev-python/libcst
	optfeature "integration with debug-server" dev-python/starlette dev-python/uvicorn \
		dev-python/websockets dev-python/python-multipart dev-python/typer dev-python/pygments \
		dev-python/rich dev-python/libcst
	optfeature "integration with django" dev-python/django dev-python/asgiref
	optfeature "integration with fastapi" dev-python/fastapi dev-python/python-multipart
	optfeature "integration with flask" dev-python/flask
	optfeature "integration with quart" dev-python/quart
	optfeature "integration with opentelemetry" dev-python/opentelemetry-api dev-python/opentelemetry-sdk
	optfeature "integration with pydantic" dev-python/pydantic
	optfeature "integration with pyinstrument" dev-python/pyinstrument
	optfeature "integration with sanic" dev-python/sanic
}
