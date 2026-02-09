# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 edo git-r3

DESCRIPTION="Non-blocking MongoDB driver for Tornado or asyncio"
HOMEPAGE="https://github.com/mongodb/motor"
EGIT_REPO_URI="https://github.com/mongodb/${PN}.git"

LICENSE="Apache-2.0"
SLOT="0"

RDEPEND="dev-python/pymongo[${PYTHON_USEDEP}]"
BDEPEND="dev-python/hatch-requirements-txt[${PYTHON_USEDEP}]
	test? ( dev-db/mongodb
		dev-python/aiohttp[${PYTHON_USEDEP}]
		dev-python/mockupdb[${PYTHON_USEDEP}]
		dev-python/pymongocrypt[${PYTHON_USEDEP}]
		dev-python/tornado[${PYTHON_USEDEP}] )"

EPYTEST_PLUGINS=( pytest-asyncio )
distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# no such command: 'configureFailPoint'
	test/asyncio_tests/test_asyncio_cursor.py::TestAsyncIOCursor::test_cancelled_error_fetch_next
	test/asyncio_tests/test_asyncio_cursor.py::TestAsyncIOCursor::test_cancelled_error_fetch_next_aggregate
	test/asyncio_tests/test_asyncio_cursor.py::TestAsyncIOCursor::test_cancelled_error_to_list
)

src_test() {
	edo mongod --port 27017 --bind_ip 127.0.0.1 --nounixsocket --fork \
		--dbpath="${T}" --logpath="${T}/mongod.log"
	distutils-r1_src_test
	edo kill "$(<"${T}/mongod.lock")"
}
