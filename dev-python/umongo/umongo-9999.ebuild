# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 edo git-r3 optfeature

DESCRIPTION="Sync/async MongoDB ODM"
HOMEPAGE="https://github.com/Scille/umongo"
EGIT_REPO_URI="https://github.com/Scille/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/marshmallow[${PYTHON_USEDEP}]
	dev-python/pymongo[${PYTHON_USEDEP}]"
BDEPEND="dev-python/hatch-requirements-txt[${PYTHON_USEDEP}]
	test? ( dev-python/mongomock[${PYTHON_USEDEP}]
		dev-python/motor[${PYTHON_USEDEP}]
		dev-python/txmongo[${PYTHON_USEDEP}] )"

EPYTEST_PLUGINS=( pytest-twisted )
distutils_enable_tests pytest

src_test() {
	edo mongod --port 27017 --bind_ip 127.0.0.1 --nounixsocket --fork \
		--dbpath="${T}" --logpath="${T}/mongod.log"
	distutils-r1_src_test
	edo kill "$(<"${T}/mongod.lock")"
}

pkg_postinst() {
	optfeature "integration with mongomock" dev-python/mongomock
	optfeature "integration with motor" dev-python/motor
	optfeature "integration with txmongo" dev-python/txmongo
}
