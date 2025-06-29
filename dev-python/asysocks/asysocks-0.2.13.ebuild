# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="Asynchronous socks and http proxy library"
HOMEPAGE="https://github.com/skelsec/asysocks"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test" # no tests

RDEPEND="dev-python/asn1crypto[${PYTHON_USEDEP}]
	dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/h11[${PYTHON_USEDEP}]"
