# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 git-r3

DESCRIPTION="Library for mocking AsyncIOMotorClient built on top of mongomock"
HOMEPAGE="https://github.com/michaelkryukov/mongomock_motor"
EGIT_REPO_URI="https://github.com/michaelkryukov/mongomock_motor.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/mongomock[${PYTHON_USEDEP}]
	dev-python/motor[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/beanie[${PYTHON_USEDEP}]
		dev-python/mongo-thingy[${PYTHON_USEDEP}]
		dev-python/umongo[${PYTHON_USEDEP}] )"

EPYTEST_PLUGINS=( pytest-asyncio )
distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# AttributeError
	tests/test_beanie.py::test_beanie
	# TypeError
	tests/test_beanie.py::test_beanie_links
)
