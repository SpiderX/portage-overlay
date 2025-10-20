# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="Microsoft Azure Storage Blobs Library for Python"
HOMEPAGE="https://github.com/Azure/azure-sdk-for-python"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test" # https://github.com/Azure/azure-sdk-for-python/issues/9616

RDEPEND="dev-python/azure-core[${PYTHON_USEDEP}]
	dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/isodate[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]"

DOCS=( {CHANGELOG,README}.md )

distutils_enable_tests pytest

pkg_postinst() {
	optfeature "support of aio" dev-python/azure-core dev-python/aiohttp
}
