# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12,13} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="A library for working with web frameworks"
HOMEPAGE="https://github.com/usecross/cross-web"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/typing-extensions[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/aiohttp[${PYTHON_USEDEP}]
		dev-python/chalice[${PYTHON_USEDEP}]
		dev-python/fastapi[${PYTHON_USEDEP}]
		dev-python/httpx[${PYTHON_USEDEP}]
		dev-python/quart[${PYTHON_USEDEP}]
		dev-python/sanic[${PYTHON_USEDEP}] )"

EPYTEST_PLUGINS=( pytest-asyncio )
distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# NameError: name 'Request' is not defined
	tests/request/test_sanic.py::test_sanic_adapter
	tests/request/test_sanic.py::test_sanic_adapter_json
)

pkg_postinst() {
	optfeature "integration with fastapi" dev-python/fastapi
	optfeature "integration with httpx" dev-python/httpx
	optfeature "integration with multipart" dev-python/python-multipart
	optfeature "integration with starlette" dev-python/starlette
	optfeature "integration with django" dev-python/django
	optfeature "integration with flask" dev-python/flask
	optfeature "integration with werkzeug" dev-python/werkzeug
	optfeature "integration with aiohttp" dev-python/aiohttp
	optfeature "integration with yarl" dev-python/yarl
	optfeature "integration with quart" dev-python/quart
	optfeature "integration with litestart" dev-python/litestart
	optfeature "integration with sanic" dev-python/sanic dev-python/sanic-testing
	optfeature "integration with chalice" dev-python/chalice
}
