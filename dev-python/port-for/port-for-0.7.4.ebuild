# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="An utility and python library for TCP ports management"
HOMEPAGE="https://github.com/fizyk/port-for"
SRC_URI="https://github.com/fizyk/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/urllib3[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
