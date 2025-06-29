# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1

DESCRIPTION="Kerberos manipulation library"
HOMEPAGE="https://github.com/skelsec/minikerberos"
SRC_URI="https://github.com/skelsec/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-python/asn1crypto[${PYTHON_USEDEP}]
	dev-python/asysocks[${PYTHON_USEDEP}]
	dev-python/oscrypto[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
	dev-python/unicrypto[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

EPYTEST_IGNORE=(
	# needs KDC
	tests/test_conn_blocking.py
	tests/test_conn.py
	tests/test_security.py
)
