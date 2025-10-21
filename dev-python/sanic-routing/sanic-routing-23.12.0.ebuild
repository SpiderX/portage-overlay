# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="Core routing component for Sanic"
HOMEPAGE="https://github.com/sanic-org/sanic-routing"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

EPYTEST_PLUGINS=( pytest-asyncio )
distutils_enable_tests pytest
