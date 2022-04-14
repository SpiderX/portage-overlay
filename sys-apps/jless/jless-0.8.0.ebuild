# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# shellcheck disable=SC2086

EAPI=8

CRATES="
	aho-corasick-0.7.18
	atty-0.2.14
	autocfg-1.0.1
	beef-0.5.1
	bitflags-1.2.1
	block-0.1.6
	cc-1.0.69
	cfg-if-0.1.10
	cfg-if-1.0.0
	clap-3.0.14
	clap_derive-3.0.14
	clipboard-0.5.0
	clipboard-win-2.2.0
	clipboard-win-4.2.1
	dirs-next-2.0.0
	dirs-sys-next-0.1.2
	endian-type-0.1.2
	error-code-2.3.0
	fd-lock-3.0.0
	fnv-1.0.7
	getrandom-0.2.3
	hashbrown-0.11.2
	heck-0.4.0
	hermit-abi-0.1.18
	indexmap-1.8.0
	indoc-1.0.4
	isatty-0.1.9
	lazy_static-1.4.0
	libc-0.2.99
	libc-stdhandle-0.1.0
	linked-hash-map-0.5.4
	log-0.4.14
	logos-0.12.0
	logos-derive-0.12.0
	malloc_buf-0.0.6
	memchr-2.4.1
	memoffset-0.6.4
	nibble_vec-0.1.0
	nix-0.22.1
	numtoa-0.1.0
	objc-0.2.7
	objc-foundation-0.1.1
	objc_id-0.1.1
	os_str_bytes-6.0.0
	proc-macro-error-1.0.4
	proc-macro-error-attr-1.0.4
	proc-macro2-1.0.36
	quote-1.0.9
	radix_trie-0.2.1
	redox_syscall-0.1.57
	redox_syscall-0.2.6
	redox_termios-0.1.2
	redox_users-0.4.0
	regex-1.5.5
	regex-syntax-0.6.25
	rustyline-9.0.0
	scopeguard-1.1.0
	signal-hook-0.3.8
	signal-hook-registry-1.3.0
	smallvec-1.6.1
	str-buf-1.0.5
	strsim-0.10.0
	syn-1.0.86
	termcolor-1.1.2
	termion-1.5.6
	textwrap-0.14.2
	unicode-segmentation-1.7.1
	unicode-width-0.1.8
	unicode-xid-0.2.1
	unindent-0.1.8
	utf8-ranges-1.0.4
	utf8parse-0.2.0
	version_check-0.9.3
	wasi-0.10.2+wasi-snapshot-preview1
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
	x11-clipboard-0.3.3
	xcb-0.8.2
	yaml-rust-0.4.5
"

inherit cargo

DESCRIPTION="Command-line JSON viewer"
HOMEPAGE="https://github.com/PaulJuliusMartinez/jless"
SRC_URI="https://github.com/PaulJuliusMartinez/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris ${CRATES})"

LICENSE="Apache-2.0 MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DOCS=( {CHANGELOG,README,SEARCH}.md )

QA_FLAGS_IGNORED="usr/bin/jless"
