# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=maturin
PYTHON_COMPAT=( python3_{10..13} )
EGIT_REPO_URI="https://github.com/pydantic/${PN}.git"

inherit cargo distutils-r1 git-r3

DESCRIPTION="Fast iterable JSON parser"
HOMEPAGE="https://github.com/pydantic/jiter"

LICENSE="Apache-2.0 Boost-1.0 Apache-2.0-with-LLVM-exceptions MIT MPL-2.0 UoI-NCSA Unicode-3.0"
SLOT="0"
RESTRICT="test" # requires nodejs

RDEPEND="dev-python/orjson[${PYTHON_USEDEP}]
	dev-python/ujson[${PYTHON_USEDEP}]"
BDEPEND="dev-util/maturin[${PYTHON_USEDEP}]"

QA_FLAGS_IGNORED="usr/lib/python.*/site-packages/jiter/jiter.*.so"

distutils_enable_tests pytest
