# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Python Circuit Breaker pattern implementation"
HOMEPAGE="https://github.com/fabfuel/circuitbreaker"
EGIT_REPO_URI="https://github.com/fabfuel/${PN}.git"

LICENSE="BSD"
SLOT="0"

PATCHES=( "${FILESDIR}/${PN}"-2.1.3-tests.patch )

EPYTEST_PLUGINS=( pytest-{asyncio,mock} )
distutils_enable_tests pytest
