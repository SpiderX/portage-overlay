# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1

DESCRIPTION="Windows registry file reader"
HOMEPAGE="https://github.com/skelsec/aiowinreg"
SRC_URI="https://github.com/skelsec/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND="dev-python/prompt-toolkit[${PYTHON_USEDEP}]
	dev-python/winacl[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/pytest-asyncio[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
