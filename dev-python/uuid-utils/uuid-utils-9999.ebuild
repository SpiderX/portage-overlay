# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=maturin
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{12,13} python3_13t )

inherit cargo distutils-r1 git-r3

DESCRIPTION="Python bindings to Rust UUID"
HOMEPAGE="https://github.com/aminalaee/uuid-utils"
EGIT_REPO_URI="https://github.com/aminalaee/${PN}.git"

LICENSE="Apache-2.0-with-LLVM-exceptions BSD MIT Unicode-DFS-2016"
SLOT="0"

QA_FLAGS_IGNORED="usr/lib/python3.*/site-packages/uuid_utils/_uuid_utils.abi3.so"

EPYTEST_PLUGINS=( pytest-{benchmark,codspeed} )
distutils_enable_tests pytest

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}
