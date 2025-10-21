# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 edo git-r3

DESCRIPTION="Asynchronous Python driver for MongoDB"
HOMEPAGE="https://github.com/twisted/txmongo"
EGIT_REPO_URI="https://github.com/twisted/${PN}.git"

LICENSE="Apache-2.0"
SLOT="0"

RDEPEND="dev-python/pymongo[${PYTHON_USEDEP}]
	dev-python/twisted[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-db/mongodb )"

distutils_enable_tests pytest

EPYTEST_IGNORE=(
	# No module named 'xmlrpclib'
	examples/webapps/test_xmlrpc.py
)

src_test() {
	edo mongod --port 27017 --bind_ip 127.0.0.1 --nounixsocket --fork \
		--dbpath="${T}" --logpath="${T}/mongod.log"
	distutils-r1_src_test
	edo kill "$(<"${T}/mongod.lock")"
}
