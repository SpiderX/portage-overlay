# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Unified interface for cryptographic libraries"
HOMEPAGE="https://github.com/skelsec/unicrypto"
EGIT_REPO_URI="https://github.com/skelsec/${PN}.git"

LICENSE="MIT"
SLOT="0"
IUSE="test"

CDEPEND="dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/mbedtls[${PYTHON_USEDEP}]"
RDEPEND="|| ( dev-python/pycryptodome[${PYTHON_USEDEP}]
		${CDEPEND} )"
BDEPEND="test? ( ${CDEPEND} )"

distutils_enable_tests pytest

python_prepare_all() {
	# use pycryptodome instead of pycryptodomex
	sed -i 's/Cryptodome/Crypto/' unicrypto/__init__.py \
		unicrypto/backends/pycryptodomex/{AES,DES,RC4,TDES}.py \
		tests/trace || die "sed failed for cryptodomex"

	# don't install tests
	sed -i '/find_packages/s/)/exclude=["tests*"])/' setup.py \
		|| die "sed failed for setup.py"

	distutils-r1_python_prepare_all
}
