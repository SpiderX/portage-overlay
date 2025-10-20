# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1

DESCRIPTION="Python based FIDO 2.0 library"
HOMEPAGE="https://github.com/Yubico/python-fido2"
SRC_URI="https://github.com/Yubico/python-fido2/releases/download/${PV}/${P}.tar.gz"

LICENSE="Apache-2.0 BSD-2 MIT MPL-2.0"
SLOT="0/0.9"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/six[${PYTHON_USEDEP}]
	dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/pyscard[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/mock[${PYTHON_USEDEP}] )"

distutils_enable_tests unittest
