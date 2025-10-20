# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 edo git-r3

DESCRIPTION="Python Object-Document Mapper for working with MongoDB"
HOMEPAGE="https://github.com/MongoEngine/mongoengine"
EGIT_REPO_URI="https://github.com/MongoEngine/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/pymongo[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/blinker[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# Transaction numbers are only allowed on a replica set member
	tests/test_context_managers.py::TestContextManagers
)

src_test() {
	edo mongod --port 27017 --bind_ip 127.0.0.1 --nounixsocket --fork \
		--dbpath="${T}" --logpath="${T}/mongod.log"
	# ulimit -n 4096
	distutils-r1_src_test
	edo kill "$(<"${T}/mongod.lock")"
}
