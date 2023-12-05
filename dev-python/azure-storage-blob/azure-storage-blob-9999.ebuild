# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..12} )
EGIT_REPO_URI="https://github.com/Azure/azure-sdk-for-python.git"

inherit distutils-r1 git-r3

DESCRIPTION="Microsoft Azure Storage Blobs Library for Python"
HOMEPAGE="https://github.com/Azure/azure-sdk-for-python"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
RESTRICT="test" # https://github.com/Azure/azure-sdk-for-python/issues/9616

RDEPEND="dev-python/azure-core[${PYTHON_USEDEP}]
	dev-python/msrest[${PYTHON_USEDEP}]
	dev-python/cryptography[${PYTHON_USEDEP}]"

DOCS=( {CHANGELOG,README}.md )

distutils_enable_tests pytest
