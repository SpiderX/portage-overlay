# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="Some handy archive helpers for Python"
HOMEPAGE="https://github.com/domdfcoding/handy-archives"
SRC_URI="https://github.com/domdfcoding/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="test? ( dev-python/coincidence[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
