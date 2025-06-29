# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Cryptographic library with an mbed TLS back end"
HOMEPAGE="https://github.com/Synss/python-mbedtls"
EGIT_REPO_URI="https://github.com/mtkennerly/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/certifi[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
	net-libs/mbedtls:0"
BDEPEND="dev-python/cython"

distutils_enable_tests pytest
