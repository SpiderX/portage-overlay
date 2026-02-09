# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="Extend Sanic installation with some core functionality"
HOMEPAGE="https://github.com/sanic-org/sanic-ext"
SRC_URI="https://github.com/sanic-org/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/pyyaml[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/sanic-testing[${PYTHON_USEDEP}] )"

EPYTEST_PLUGINS=( pytest-asyncio )
distutils_enable_tests pytest
