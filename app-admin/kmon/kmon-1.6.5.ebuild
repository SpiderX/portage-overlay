# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# shellcheck disable=SC2086

EAPI=8

CRATES="ahash@0.8.11
	allocator-api2@0.2.16
	anstream@0.6.13
	anstyle@1.0.6
	anstyle-parse@0.2.3
	anstyle-query@1.0.2
	anstyle-wincon@3.0.2
	autocfg@1.2.0
	bitflags@1.3.2
	bitflags@2.5.0
	block@0.1.6
	bytesize@1.3.0
	cassowary@0.3.0
	castaway@0.2.2
	cfg-if@1.0.0
	clap@4.5.4
	clap_builder@4.5.2
	clap_complete@4.5.2
	clap_lex@0.7.0
	clap_mangen@0.2.20
	clipboard-win@3.1.1
	colorchoice@1.0.0
	colorsys@0.6.7
	compact_str@0.7.1
	copypasta@0.8.2
	copypasta-ext@0.4.4
	dlib@0.5.2
	downcast-rs@1.2.1
	either@1.10.0
	enum-iterator@2.0.0
	enum-iterator-derive@1.3.0
	errno@0.3.8
	gethostname@0.2.3
	hashbrown@0.14.3
	heck@0.4.1
	home@0.5.9
	indoc@2.0.5
	itertools@0.12.1
	itoa@1.0.11
	kmon@1.6.5
	lazy-bytes-cast@5.0.1
	lazy_static@1.4.0
	libc@0.2.153
	libloading@0.8.3
	libredox@0.0.2
	linux-raw-sys@0.4.13
	log@0.4.21
	lru@0.12.3
	malloc_buf@0.0.6
	memmap2@0.5.10
	memoffset@0.6.5
	nix@0.24.3
	numtoa@0.1.0
	objc@0.2.7
	objc-foundation@0.1.1
	objc_id@0.1.1
	once_cell@1.19.0
	paste@1.0.14
	pkg-config@0.3.30
	proc-macro2@1.0.79
	quote@1.0.36
	ratatui@0.26.1
	redox_syscall@0.4.1
	redox_termios@0.1.3
	roff@0.2.1
	rustix@0.38.32
	rustversion@1.0.15
	ryu@1.0.17
	scoped-tls@1.0.1
	smallvec@1.13.2
	smithay-client-toolkit@0.16.1
	smithay-clipboard@0.6.6
	stability@0.1.1
	static_assertions@1.1.0
	strsim@0.11.1
	strum@0.26.2
	strum_macros@0.26.2
	syn@1.0.109
	syn@2.0.58
	termion@3.0.0
	unicode-ident@1.0.12
	unicode-segmentation@1.11.0
	unicode-width@0.1.11
	utf8parse@0.2.1
	version_check@0.9.4
	wayland-client@0.29.5
	wayland-commons@0.29.5
	wayland-cursor@0.29.5
	wayland-protocols@0.29.5
	wayland-scanner@0.29.5
	wayland-sys@0.29.5
	which@4.4.2
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-wsapoll@0.1.2
	winapi-x86_64-pc-windows-gnu@0.4.0
	windows-sys@0.52.0
	windows-targets@0.52.4
	windows_aarch64_gnullvm@0.52.4
	windows_aarch64_msvc@0.52.4
	windows_i686_gnu@0.52.4
	windows_i686_msvc@0.52.4
	windows_x86_64_gnu@0.52.4
	windows_x86_64_gnullvm@0.52.4
	windows_x86_64_msvc@0.52.4
	x11-clipboard@0.7.1
	x11rb@0.10.1
	x11rb-protocol@0.10.0
	xcursor@0.3.5
	xml-rs@0.8.20
	zerocopy@0.7.32
	zerocopy-derive@0.7.32"

inherit cargo

DESCRIPTION="Linux Kernel Manager and Activity Monitor"
HOMEPAGE="https://github.com/orhun/kmon"
SRC_URI="${CARGO_CRATE_URIS}"

LICENSE="Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 Boost-1.0 GPL-3 ISC MIT Unicode-DFS-2016"
SLOT="0"
KEYWORDS="~amd64"

DOCS=( {CHANGELOG,README}.md )

QA_PREBUILT="usr/bin/kmon"

src_install() {
	einstalldocs
	cargo_src_install
}
