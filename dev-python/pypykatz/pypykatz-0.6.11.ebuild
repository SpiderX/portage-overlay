# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="Python library to extract passwords from memory"
HOMEPAGE="https://github.com/skelsec/pypykatz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test" # no tests

RDEPEND="dev-python/aesedb[${PYTHON_USEDEP}]
	dev-python/aiosmb[${PYTHON_USEDEP}]
	dev-python/aiowinreg[${PYTHON_USEDEP}]
	dev-python/minidump[${PYTHON_USEDEP}]
	dev-python/minikerberos[${PYTHON_USEDEP}]
	dev-python/msldap[${PYTHON_USEDEP}]
	dev-python/unicrypto[${PYTHON_USEDEP}]
	dev-python/winacl[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
