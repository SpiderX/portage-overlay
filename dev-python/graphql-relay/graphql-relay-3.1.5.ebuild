# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

MY_PN="${PN}-py"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A library to help construct a graphql-py server supporting react-relay"
HOMEPAGE="https://github.com/graphql-python/graphql-relay-py"
SRC_URI="https://github.com/graphql-python/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="<dev-python/graphql-core-3.2[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		dev-python/pytest-describe[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${MY_P}"

distutils_enable_tests pytest
