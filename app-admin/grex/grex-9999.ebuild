# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=maturin
PYTHON_COMPAT=( python3_{11..14} )
RUST_MIN_VER="1.82.0"

inherit cargo distutils-r1 git-r3

DESCRIPTION="A CLI tool for generating regular expressions"
HOMEPAGE="https://github.com/pemistahl/grex"
EGIT_REPO_URI="https://github.com/pemistahl/${PN}.git"

LICENSE="Apache-2.0 Apache-2.0-with-LLVM-exceptions Boost-1.0 MIT Unlicense"
SLOT="0"

DOCS=( {README,RELEASE_NOTES}.md )

QA_FLAGS_IGNORED="usr/bin/grex
	usr/lib/python.*/site-packages/grex/grex.cpython-.*-x86_64-linux-gnu.so"

distutils_enable_tests pytest

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}

src_configure() {
	cargo_src_configure
	distutils-r1_src_configure
}

src_compile() {
	cargo_src_compile
	distutils-r1_src_compile
}

src_test() {
	cargo_src_test
	distutils-r1_src_test
}

src_install() {
	einstalldocs
	cargo_src_install
	distutils-r1_src_install
}
