# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="Python port of GraphQL.js"
HOMEPAGE="https://github.com/graphql-python/graphql-core"
SRC_URI="https://github.com/graphql-python/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

EPYTEST_PLUGINS=( pytest-{asyncio,benchmark,timeout} )
distutils_enable_tests pytest
