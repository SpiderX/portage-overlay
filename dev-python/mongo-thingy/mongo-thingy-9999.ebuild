# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12,13} )

inherit distutils-r1 edo git-r3

DESCRIPTION="Object-Document Mapper to use MongoDB with Python"
HOMEPAGE="https://github.com/Refty/mongo-thingy"
EGIT_REPO_URI="https://github.com/Refty/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/pymongo[${PYTHON_USEDEP}]
	dev-python/thingy[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/mongomock[${PYTHON_USEDEP}]
		dev-python/mongomock-motor[${PYTHON_USEDEP}]
		dev-python/motor[${PYTHON_USEDEP}] )"
# dev-python/montydb[${PYTHON_USEDEP}]
# montydb has been config to use BSON and cannot be changed in current session.

distutils_enable_tests pytest

python_prepare_all() {
	# disable pytest options
	sed -i '/addopts/d' setup.cfg || die "sed failed for setup.cfg"

	distutils-r1_python_prepare_all
}

src_test() {
	edo mongod --port 27017 --bind_ip 127.0.0.1 --nounixsocket --fork \
		--dbpath="${T}" --logpath="${T}/mongod.log"
	distutils-r1_src_test
	edo kill "$(<"${T}/mongod.lock")"
}
