# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{10..13} python3_13t )

inherit distutils-r1 git-r3

MY_PN="${PN//google/python}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Hardware-based implementation of the CRC32C hashing algorithm"
HOMEPAGE="https://github.com/googleapis/python-crc32c"
EGIT_REPO_URI="https://github.com/googleapis/python-cloud-core.git"
S="${WORKDIR}/${MY_P}"

LICENSE="Apache-2.0"
SLOT="0"

RDEPEND="dev-libs/crc32c"

distutils_enable_tests pytest
