# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )
EGIT_REPO_URI="https://github.com/ncclient/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Python library for NETCONF clients"
HOMEPAGE="https://github.com/ncclient/ncclient"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/paramiko[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
