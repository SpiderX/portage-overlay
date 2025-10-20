# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 git-r3

DESCRIPTION="Mock data generation factories"
HOMEPAGE="https://github.com/litestar-org/polyfactory"
EGIT_REPO_URI="https://github.com/litestar-org/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/faker[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/aiosqlite[${PYTHON_USEDEP}]
		dev-python/annotated-types[${PYTHON_USEDEP}]
		dev-python/beanie[${PYTHON_USEDEP}]
		dev-python/email-validator[${PYTHON_USEDEP}]
		dev-python/greenlet[${PYTHON_USEDEP}]
		dev-python/hypothesis[${PYTHON_USEDEP}]
		dev-python/mongomock-motor[${PYTHON_USEDEP}]
		dev-python/msgspec[${PYTHON_USEDEP}]
		dev-python/pymongo[${PYTHON_USEDEP}]
		dev-python/sqlalchemy[${PYTHON_USEDEP}] )"

EPYTEST_PLUGINS=( pytest-asyncio )
distutils_enable_tests pytest
