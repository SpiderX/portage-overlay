# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=maturin
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{12..14} )

inherit cargo distutils-r1 git-r3

DESCRIPTION="Analyze and extract information from Jinja used in dbt projects"
HOMEPAGE="https://github.com/dbt-labs/dbt-extractor"
EGIT_REPO_URI="https://github.com/dbt-labs/${PN}.git"

LICENSE="Apache-2.0 Apache-2.0-with-LLVM-exceptions MIT Unicode-3.0"
SLOT="0"

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
}

src_install() {
	cargo_src_install
	distutils-r1_src_install
}
