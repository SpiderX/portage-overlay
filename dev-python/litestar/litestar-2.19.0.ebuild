# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12,13} )

inherit distutils-r1 optfeature

DESCRIPTION="A production-ready, highly performant, extensible ASGI API Framework"
HOMEPAGE="https://github.com/litestar-org/litestar"
SRC_URI="https://github.com/litestar-org/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/anyio[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/httpx[${PYTHON_USEDEP}]
	dev-python/litestar-htmx[${PYTHON_USEDEP}]
	dev-python/msgspec[${PYTHON_USEDEP}]
	dev-python/multidict[${PYTHON_USEDEP}]
	dev-python/multipart[${PYTHON_USEDEP}]
	dev-python/polyfactory[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/rich[${PYTHON_USEDEP}]
	dev-python/rich-click[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/advanced-alchemy[${PYTHON_USEDEP}]
		dev-python/annotated-types[${PYTHON_USEDEP}]
		dev-python/asyncpg[${PYTHON_USEDEP}]
		dev-python/attrs[${PYTHON_USEDEP}]
		dev-python/beautifulsoup4[${PYTHON_USEDEP}]
		app-arch/brotli[python,${PYTHON_USEDEP}]
		dev-python/cryptography[${PYTHON_USEDEP}]
		dev-python/email-validator[${PYTHON_USEDEP}]
		dev-python/flaky[${PYTHON_USEDEP}]
		dev-python/fsspec[${PYTHON_USEDEP}]
		dev-python/httpx-sse[${PYTHON_USEDEP}]
		dev-python/jinja2[${PYTHON_USEDEP}]
		dev-python/libvalkey[${PYTHON_USEDEP}]
		dev-python/mako[${PYTHON_USEDEP}]
		dev-python/minijinja[${PYTHON_USEDEP}]
		dev-python/opentelemetry-instrumentation-asgi[${PYTHON_USEDEP}]
		dev-python/prometheus-client[${PYTHON_USEDEP}]
		dev-python/pydantic[${PYTHON_USEDEP}]
		dev-python/pydantic-extra-types[${PYTHON_USEDEP}]
		dev-python/pyjwt[${PYTHON_USEDEP}]
		dev-python/redis[${PYTHON_USEDEP}]
		dev-python/structlog[${PYTHON_USEDEP}]
		dev-python/time-machine[${PYTHON_USEDEP}]
		dev-python/valkey[${PYTHON_USEDEP}] )"

EPYTEST_PLUGINS=( pytest-{asyncio,lazy-fixtures,mock,timeout,xdist} flaky )
distutils_enable_tests pytest

EPYTEST_IGNORE=(
	# needs docker
	tests/e2e/test_response_caching.py
	tests/unit/test_channels/test_backends.py
	tests/unit/test_channels/test_plugin.py
	tests/unit/test_stores.py
	tests/unit/test_testing/test_test_client.py
	docs/examples/testing/test_with_portal.py
)

EPYTEST_DESELECT=(
	# TypeError
	tests/unit/test_plugins/test_prometheus.py::test_prometheus_exporter_metrics_with_http
	# AssertionError
	tests/e2e/test_logging/test_structlog_to_file.py::test_structlog_to_file
	tests/unit/test_connection/test_request.py::test_request_headers
	tests/unit/test_connection/test_websocket.py::test_websocket_headers
)

pkg_postinst() {
	optfeature "integration with annotated-types" dev-python/annotated-types
	optfeature "integration with attrs" dev-python/attrs
	optfeature "integration with brotli" app-arch/brotli[python]
	optfeature "integration with cryptography" dev-python/cryptography
	optfeature "integration with jinja" dev-python/jinja2
	optfeature "integration with jwt" dev-python/cryptography dev-python/pyjwt
	optfeature "integration with mako" dev-python/mako
	optfeature "integration with minijinja" dev-python/minijinja
	optfeature "integration with prometheus" dev-python/prometheus-client
	optfeature "integration with pydantic" dev-python/email-validator dev-python/pydantic \
		dev-python/pydantic-extra-types
	optfeature "integration with sqlalchemy" dev-python/advanced-alchemy
	optfeature "integration with structlog" dev-python/structlog
	optfeature "integration with valkey" dev-python/valkey dev-python/libvalkey
}
