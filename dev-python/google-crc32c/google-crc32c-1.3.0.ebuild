# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

MY_PN="${PN//google/python}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Hardware-based implementation of the CRC32C hashing algorithm"
HOMEPAGE="https://github.com/googleapis/python-crc32c"
SRC_URI="https://github.com/googleapis/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-libs/crc32c"

S="${WORKDIR}/${MY_P}"

distutils_enable_tests pytest
