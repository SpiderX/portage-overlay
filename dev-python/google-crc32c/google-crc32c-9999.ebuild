# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
EGIT_SUBMODULES=()
PYTHON_COMPAT=( python3_{12..15} python3_{13..15}t )

inherit distutils-r1 git-r3

DESCRIPTION="Hardware-based implementation of the CRC32C hashing algorithm"
HOMEPAGE="https://github.com/googleapis/python-crc32c"
EGIT_REPO_URI="https://github.com/googleapis/python-crc32c.git"

LICENSE="Apache-2.0"
SLOT="0"

RDEPEND="dev-libs/crc32c"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
