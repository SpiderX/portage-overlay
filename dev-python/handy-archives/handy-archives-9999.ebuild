# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 edo git-r3

DESCRIPTION="Small library for mocking pymongo collection objects for testing purposes"
HOMEPAGE="https://github.com/mongomock/mongomock"
EGIT_REPO_URI="https://github.com/mongomock/${PN}.git"

LICENSE="ISC"
SLOT="0"

RDEPEND="dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/pymongo[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	dev-python/sentinels[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-db/mongodb )"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# AssertionError: Unexpected Diff:
	tests/test__mongomock.py::MongoClientAggregateTest::test__aggregate_regexpmatch
)

src_test() {
	edo mongod --port 27017 --bind_ip 127.0.0.1 --nounixsocket --fork \
		--dbpath="${T}" --logpath="${T}/mongod.log"
	distutils-r1_src_test
	edo kill "$(<"${T}/mongod.lock")"
}
