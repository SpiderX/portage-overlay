# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="Microsoft Azure Storage Blobs Library for Python"
HOMEPAGE="https://github.com/Azure/azure-sdk-for-python"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # not ready

RDEPEND="dev-python/azure-core[${PYTHON_USEDEP}]
	dev-python/msrest[${PYTHON_USEDEP}]
	dev-python/cryptography[${PYTHON_USEDEP}]"
BDEPEND="app-arch/unzip"

DOCS=( {CHANGELOG,README}.md )

distutils_enable_tests pytest
