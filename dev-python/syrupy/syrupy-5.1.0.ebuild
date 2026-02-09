# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="Pytest Snapshot Test Utility"
HOMEPAGE="https://github.com/syrupy-project/syrupy"
SRC_URI="https://github.com/syrupy-project/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/pytest[${PYTHON_USEDEP}]"

EPYTEST_PLUGINS=( )
distutils_enable_tests pytest

EPYTEST_IGNORE=( tests/integration )
