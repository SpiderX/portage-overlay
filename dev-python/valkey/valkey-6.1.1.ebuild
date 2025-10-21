# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 optfeature

MY_PN="${PN}-py"

DESCRIPTION="The Python interface to the Valkey key-value store"
HOMEPAGE="https://github.com/valkey-io/valkey-py"
SRC_URI="https://github.com/valkey-io/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test" # needs valkey

BDEPEND="test? ( dev-python/cryptography[${PYTHON_USEDEP}]
		dev-python/libvalkey[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

pkg_postinst() {
	optfeature "integration with libvalkey" dev-python/libvalkey
	optfeature "integration with ocsp" dev-python/cryptography dev-python/pyopenssl dev-python/requests
}
