# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# shellcheck disable=SC2086

EAPI=8

CRATES="aho-corasick@0.7.13
	ansi_term@0.11.0
	atty@0.2.14
	backslash@0.1.0
	bitflags@1.2.1
	clap@2.33.1
	heck@0.3.1
	hermit-abi@0.1.14
	lazy_static@1.4.0
	libc@0.2.71
	memchr@2.3.3
	proc-macro-error@1.0.3
	proc-macro-error-attr@1.0.3
	proc-macro2@1.0.18
	quote@1.0.7
	regex@1.3.9
	regex-syntax@0.6.18
	strsim@0.8.0
	structopt@0.3.15
	structopt-derive@0.4.8
	syn@1.0.33
	syn-mid@0.5.0
	textwrap@0.11.0
	thread_local@1.0.1
	unicode-segmentation@1.6.0
	unicode-width@0.1.7
	unicode-xid@0.2.1
	vec_map@0.8.2
	version_check@0.9.2
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-x86_64-pc-windows-gnu@0.4.0
	${PN}@${PV}"

inherit cargo

DESCRIPTION="Fast alternative to cut and awk"
HOMEPAGE="https://github.com/theryangeary/choose"
SRC_URI="${CARGO_CRATE_URIS}"

LICENSE="Apache-2.0 GPL-3+ MIT Unlicense"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DOCS=( readme.md )

QA_FLAGS_IGNORED="usr/bin/choose"

src_install() {
	einstalldocs
	cargo_src_install
}
