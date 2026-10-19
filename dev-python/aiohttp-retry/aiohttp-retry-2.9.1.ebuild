# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1

DESCRIPTION="Simple aiohttp retry client"
HOMEPAGE="https://github.com/inyutin/aiohttp_retry"
SRC_URI="https://github.com/inyutin/${PN/-/_}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${PN/-/_}-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

RDEPEND="dev-python/aiohttp[${PYTHON_USEDEP}]
	dev-python/yarl[${PYTHON_USEDEP}]"

EPYTEST_PLUGINS=( pytest-{asyncio,aiohttp} )
distutils_enable_tests pytest
