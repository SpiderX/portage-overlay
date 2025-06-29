# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 git-r3

DESCRIPTION="NTDS parser toolkit"
HOMEPAGE="https://github.com/skelsec/aesedb"
EGIT_REPO_URI="https://github.com/skelsec/${PN}.git"

LICENSE="Apache-1.1"
SLOT="0"
IUSE="test"

RDEPEND="dev-python/aiowinreg[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
	dev-python/unicrypto[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/pytest-asyncio[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
