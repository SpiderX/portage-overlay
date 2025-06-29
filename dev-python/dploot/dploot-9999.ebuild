# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 git-r3

DESCRIPTION="DPAPI looting remotely and locally"
HOMEPAGE="https://github.com/zblurx/dploot"
EGIT_REPO_URI="https://github.com/zblurx/${PN}.git"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # no tests

RDEPEND="dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/impacket[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/pyasn1[${PYTHON_USEDEP}]
	dev-python/pycryptodome[${PYTHON_USEDEP}]"

python_prepare_all() {
	# use pycryptodome instead of pycryptodomex
	sed -i 's/Cryptodome/Crypto/' dploot/triage/{browser,certificates,mobaxterm}.py \
		dploot/lib/{crypto,dpapi,masterkey}.py || die "sed failed for cryptodomex"

	distutils-r1_python_prepare_all
}
