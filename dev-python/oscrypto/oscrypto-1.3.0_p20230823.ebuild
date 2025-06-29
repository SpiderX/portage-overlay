# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1

COMMIT="1547f535001ba568b239b8797465536759c742a3"

DESCRIPTION="Kerberos manipulation library"
HOMEPAGE="https://github.com/wbond/oscrypto"
SRC_URI="https://github.com/wbond/oscrypto/archive/${COMMIT}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/asn1crypto[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

EPYTEST_IGNORE=(
	# no wildcard-match.badtls.io
	tests/test_tls.py
)
