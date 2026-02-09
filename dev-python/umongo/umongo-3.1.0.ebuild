# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12,13} )

inherit distutils-r1 edo optfeature pypi

DESCRIPTION="Sync/async MongoDB ODM"
HOMEPAGE="https://github.com/Scille/umongo"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/marshmallow[${PYTHON_USEDEP}]
	dev-python/pymongo[${PYTHON_USEDEP}]"
BDEPEND="dev-python/hatch-requirements-txt[${PYTHON_USEDEP}]
	test? ( dev-python/mongomock[${PYTHON_USEDEP}]
		dev-python/motor[${PYTHON_USEDEP}]
		dev-python/txmongo[${PYTHON_USEDEP}] )"

PATCHES=( "${FILESDIR}/${PN}"-3.1.0-py3.12.patch )

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
