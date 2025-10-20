# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 edo pypi

DESCRIPTION="MongoDB Wire Protocol server library"
HOMEPAGE="https://github.com/mongodb-labs/mongo-mockup-db"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/pymongo[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-db/mongodb )"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# AttributeError
	tests/test_mockupdb.py::TestRequest::test_flags
	tests/test_mockupdb.py::TestUnacknowledgedWrites
	tests/test_mockupdb.py::TestMatcher::test_datetime
	# https://github.com/mongodb-labs/mongo-mockup-db/issues/44
	tests/test_mockupdb.py::TestAutoresponds
	# AttributeError: module 'ssl' has no attribute 'wrap_socket'
	tests/test_mockupdb.py::TestSSL
	# AssertionError
	tests/test_mockupdb.py::TestMockupDB
	tests/test_mockupdb.py::TestResponse::test_ok
)

src_test() {
	edo mongod --port 27017 --bind_ip 127.0.0.1 --nounixsocket --fork \
		--dbpath="${T}" --logpath="${T}/mongod.log"
	distutils-r1_src_test
	edo kill "$(<"${T}/mongod.lock")"
}
