# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=maturin
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{12..14} )

CRATES="aho-corasick@1.1.3
	autocfg@1.4.0
	cc@1.2.17
	cfg-if@1.0.0
	crossbeam-deque@0.8.6
	crossbeam-epoch@0.9.18
	crossbeam-utils@0.8.21
	either@1.15.0
	env_logger@0.8.4
	getrandom@0.2.15
	heck@0.5.0
	indoc@2.0.6
	libc@0.2.171
	log@0.4.27
	memchr@2.7.4
	memoffset@0.9.1
	once_cell@1.21.3
	portable-atomic@1.11.0
	proc-macro2@1.0.94
	pyo3-build-config@0.24.1
	pyo3-ffi@0.24.1
	pyo3-macros-backend@0.24.1
	pyo3-macros@0.24.1
	pyo3@0.24.1
	quickcheck@1.0.3
	quickcheck_macros@1.0.0
	quote@1.0.40
	rand@0.8.5
	rand_core@0.6.4
	rayon-core@1.12.1
	rayon@1.10.0
	regex-automata@0.4.9
	regex-syntax@0.8.5
	regex@1.11.1
	shlex@1.3.0
	syn@1.0.109
	syn@2.0.100
	target-lexicon@0.13.2
	thiserror-impl@1.0.69
	thiserror@1.0.69
	tree-sitter@0.20.10
	unicode-ident@1.0.18
	unindent@0.2.4
	wasi@0.11.0+wasi-snapshot-preview1"

declare -A GIT_CRATES=(
	[tree-sitter-jinja2]='https://github.com/dbt-labs/tree-sitter-jinja2;c9b092eff38bd6943254ad0373006d83c100a8c0;tree-sitter-jinja2-%commit%'
)

inherit cargo distutils-r1 pypi

DESCRIPTION="Analyze and extract information from Jinja used in dbt projects"
HOMEPAGE="https://github.com/dbt-labs/dbt-extractor"
SRC_URI+="
	${CARGO_CRATE_URIS}
"

LICENSE="Apache-2.0 Apache-2.0-with-LLVM-exceptions MIT Unicode-3.0"
SLOT="0"
KEYWORDS="~amd64"

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
