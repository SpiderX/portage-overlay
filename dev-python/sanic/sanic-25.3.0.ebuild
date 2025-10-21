# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="A web server and web framework that's written to go fast"
HOMEPAGE="https://github.com/sanic-org/sanic"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/aiofiles[${PYTHON_USEDEP}]
	dev-python/html5tagger[${PYTHON_USEDEP}]
	dev-python/httptools[${PYTHON_USEDEP}]
	dev-python/multidict[${PYTHON_USEDEP}]
	dev-python/sanic-routing[${PYTHON_USEDEP}]
	dev-python/tracerite[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
	dev-python/ujson[${PYTHON_USEDEP}]
	dev-python/uvloop[${PYTHON_USEDEP}]
	dev-python/websockets[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/aioquic[${PYTHON_USEDEP}]
		dev-python/sanic-testing[${PYTHON_USEDEP}] )"

PATCHES=( "${FILESDIR}/${PN}"-25.3.0-test-ipv6.patch )

EPYTEST_PLUGINS=( pytest-{asyncio,django} )
distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# Address family not supported by protocol
	tests/test_request.py::test_ipv6_address_is_not_wrapped
	# ValueError: Exception during request
	tests/test_routes.py::test_websocket_route_with_subprotocols
	# RuntimeError: Event loop is closed
	tests/test_server_events.py::test_create_server_trigger_events
	# Failed: async def functions are not natively supported.
	tests/test_touchup.py::test_ode_removes_dispatch_events
	tests/test_touchup.py::test_skip_touchup
	# FileNotFoundError: [Errno 2] No such file or directory: 'mypy'
	tests/typing/test_typing.py::test_check_app_default
	# OSError: AF_UNIX path too long
	tests/worker/test_socket.py::test_configure_socket
)

EPYTEST_IGNORE=( tests/benchmark )
