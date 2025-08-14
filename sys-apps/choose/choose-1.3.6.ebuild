# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="aho-corasick@1.1.3
	ansi_term@0.12.1
	atty@0.2.14
	backslash@0.2.0
	bitflags@1.3.2
	choose@1.3.6
	clap@2.34.0
	heck@0.3.3
	hermit-abi@0.1.19
	lazy_static@1.5.0
	libc@0.2.158
	memchr@2.7.4
	proc-macro-error-attr@1.0.4
	proc-macro-error@1.0.4
	proc-macro2@1.0.86
	quote@1.0.37
	regex-automata@0.4.7
	regex-syntax@0.8.4
	regex@1.10.6
	strsim@0.8.0
	structopt-derive@0.4.18
	structopt@0.3.26
	syn@1.0.109
	textwrap@0.11.0
	unicode-ident@1.0.13
	unicode-segmentation@1.12.0
	unicode-width@0.1.14
	vec_map@0.8.2
	version_check@0.9.5
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9"

inherit cargo

DESCRIPTION="Fast alternative to cut and awk"
HOMEPAGE="https://github.com/theryangeary/choose"
SRC_URI="${CARGO_CRATE_URIS}"

LICENSE="GPL-3+ MIT Unicode-DFS-2016"
SLOT="0"
KEYWORDS="~amd64"

DOCS=( readme.md )

QA_FLAGS_IGNORED="usr/bin/choose"

src_install() {
	einstalldocs
	cargo_src_install
}
