# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{8..10} )
EGIT_REPO_URI="https://github.com/graphql-python/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Python port of GraphQL.js"
HOMEPAGE="https://github.com/graphql-python/graphql-core"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

BDEPEND="test? ( dev-python/pytest-benchmark[${PYTHON_USEDEP}]
		dev-python/pytest-timeout[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
