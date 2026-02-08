# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12,13} )

inherit distutils-r1 git-r3

DESCRIPTION="A library to help construct a graphql-py server supporting react-relay"
HOMEPAGE="https://github.com/graphql-python/graphql-relay-py"
EGIT_REPO_URI="https://github.com/graphql-python/graphql-relay-py.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/graphql-core[${PYTHON_USEDEP}]"

EPYTEST_PLUGINS=( pytest-{asyncio,describe} )
distutils_enable_tests pytest
