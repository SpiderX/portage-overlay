# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} python3_{13,14}t )

inherit distutils-r1 pypi

DESCRIPTION="Simple python bindings to Yann Collet ZSTD compression library"
HOMEPAGE="https://github.com/sergey-dryabzhinsky/python-zstd"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="app-arch/zstd:="
RDEPEND="${DEPEND}"

distutils_enable_tests unittest

src_configure() {
	export ZSTD_EXTERNAL=1
}
