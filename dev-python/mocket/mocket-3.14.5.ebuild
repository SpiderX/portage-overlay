# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 edo pypi

DESCRIPTION="Socket Mock Framework"
HOMEPAGE="https://github.com/mindflayer/python-mocket"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-python/decorator[${PYTHON_USEDEP}]
	dev-python/h11[${PYTHON_USEDEP}]
	dev-python/puremagic[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-db/redis
		dev-python/aiohttp
		dev-python/asgiref
		dev-python/gevent
		dev-python/fastapi
		dev-python/httpx
		dev-python/redis
		dev-python/requests
		dev-python/sure )"

PATCHES=( "${FILESDIR}/${PN}"-3.14.5-tests.patch )

EPYTEST_PLUGINS=( pytest-asyncio )
distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# requires external HTTP access and times out in the test environment
	tests/test_asyncio.py::test_aiohttp
)

src_prepare() {
	default

	sed -i '/addopts/d' pyproject.toml || die "sed failed for pyproject.toml"
}

src_test() {
	local -x SKIP_TRUE_HTTP=1

	edo "${EPREFIX}"/usr/sbin/redis-server - <<-EOF
	daemonize yes
	pidfile "${T}/redis-6379.pid"
	port 6379
	bind 127.0.0.1
	EOF
	distutils-r1_src_test
	edo kill "$(<"${T}/redis-6379.pid")"
}
