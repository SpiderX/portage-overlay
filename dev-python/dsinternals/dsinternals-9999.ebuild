# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Directory Services Internals Library"
HOMEPAGE="https://github.com/p0dalirius/pydsinternals"
EGIT_REPO_URI="https://github.com/p0dalirius/${PN}.git"

LICENSE="GPL-2"
SLOT="0"

RDEPEND="dev-python/pyopenssl[${PYTHON_USEDEP}]
	dev-python/pycryptodome[${PYTHON_USEDEP}]"

python_prepare_all() {
	# use pycryptodome instead of pycryptodomex
	sed -i 's/Cryptodome/Crypto/' dsinternals/common/cryptography/RSAKeyMaterial.py \
		dsinternals/common/cryptography/X509Certificate2.py \
		|| die "sed failed for cryptodomex"

	# don't install tests
	sed -i '/find_packages/s/)/exclude=["tests*"])/' setup.py \
		|| die "sed failed for setup.py"

	distutils-r1_python_prepare_all
}

distutils_enable_tests unittest
