# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 edo optfeature

DESCRIPTION="MongoDB implemented in Python"
HOMEPAGE="https://github.com/davidlatwe/montydb"
SRC_URI="https://github.com/davidlatwe/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="test? ( dev-db/mongodb
		dev-python/lmdb[${PYTHON_USEDEP}]
		dev-python/mongoengine[${PYTHON_USEDEP}]
		dev-python/pymongo[${PYTHON_USEDEP}]
		dev-python/toml[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

EPYTEST_IGNORE=(
	# Unknown mongodb version: 8.0
	tests/test_client.py
	tests/test_collection.py
	tests/test_cursor.py
	tests/test_database.py
	tests/test_invalid_doc.py
	tests/test_mongoengine.py
	tests/test_engine
)

src_test() {
	edo mongod --port 27017 --bind_ip 127.0.0.1 --nounixsocket --fork \
		--dbpath="${T}" --logpath="${T}/mongod.log"
	distutils-r1_src_test
	edo kill "$(<"${T}/mongod.lock")"
}

pkg_postinst() {
	optfeature "integration with bson" dev-python/pymongo
	optfeature "integration with lmdb"  dev-python/lmdb
}
