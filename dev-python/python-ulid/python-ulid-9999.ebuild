# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Universally unique lexicographically sortable identifier"
HOMEPAGE="https://github.com/mdomke/python-ulid"
EGIT_REPO_URI="https://github.com/mdomke/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/pydantic[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/freezegun[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
