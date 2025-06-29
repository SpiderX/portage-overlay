# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="Asynchronous SMB protocol implementation"
HOMEPAGE="https://github.com/skelsec/aiosmb"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"

RDEPEND="dev-python/asn1crypto[${PYTHON_USEDEP}]
	dev-python/asyauth[${PYTHON_USEDEP}]
	dev-python/asysocks[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/prompt-toolkit[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
	dev-python/unicrypto[${PYTHON_USEDEP}]
	dev-python/wcwidth[${PYTHON_USEDEP}]
	dev-python/winacl[${PYTHON_USEDEP}]"
