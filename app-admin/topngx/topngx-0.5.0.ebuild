# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="aho-corasick@1.1.3
	ansi_term@0.11.0
	anstream@0.6.18
	anstyle-parse@0.2.6
	anstyle-query@1.1.2
	anstyle-wincon@3.0.7
	anstyle@1.0.10
	anyhow@1.0.31
	atty@0.2.14
	autocfg@1.1.0
	bitflags@1.3.2
	bitflags@2.9.0
	cc@1.2.18
	cfg-if@1.0.0
	cfg_aliases@0.2.1
	clap@2.33.1
	colorchoice@1.0.3
	convert_case@0.7.1
	crossbeam-channel@0.5.6
	crossbeam-deque@0.8.2
	crossbeam-epoch@0.9.10
	crossbeam-utils@0.8.11
	crossterm@0.29.0
	crossterm_winapi@0.9.1
	ctrlc@3.4.6
	derive_more-impl@2.0.1
	derive_more@2.0.1
	document-features@0.2.11
	either@1.5.3
	env_filter@0.1.3
	env_logger@0.11.8
	errno@0.3.11
	fallible-iterator@0.3.0
	fallible-streaming-iterator@0.1.9
	foldhash@0.1.5
	hashbrown@0.15.2
	hashlink@0.10.0
	heck@0.3.1
	hermit-abi@0.1.14
	is_terminal_polyfill@1.70.1
	jiff-static@0.2.5
	jiff@0.2.5
	lazy_static@1.4.0
	libc@0.2.171
	libsqlite3-sys@0.32.0
	linux-raw-sys@0.9.3
	litrs@0.4.1
	lock_api@0.4.7
	log@0.4.27
	memchr@2.7.4
	memoffset@0.6.5
	mio@1.0.3
	nix@0.29.0
	once_cell@1.21.3
	parking_lot@0.12.1
	parking_lot_core@0.9.3
	pkg-config@0.3.25
	portable-atomic-util@0.2.4
	portable-atomic@1.11.0
	proc-macro-error-attr@1.0.2
	proc-macro-error@1.0.2
	proc-macro2@1.0.94
	quote@1.0.40
	rayon-core@1.12.1
	rayon@1.10.0
	redox_syscall@0.2.16
	regex-automata@0.4.9
	regex-syntax@0.8.5
	regex@1.11.1
	rusqlite@0.34.0
	rustix@1.0.5
	scopeguard@1.1.0
	serde@1.0.219
	serde_derive@1.0.219
	shlex@1.3.0
	signal-hook-mio@0.2.4
	signal-hook-registry@1.4.0
	signal-hook@0.3.17
	smallvec@1.9.0
	strsim@0.8.0
	structopt-derive@0.4.8
	structopt@0.3.15
	syn-mid@0.5.0
	syn@1.0.33
	syn@2.0.100
	tabwriter@1.4.1
	textwrap@0.11.0
	unicode-ident@1.0.18
	unicode-segmentation@1.12.0
	unicode-width@0.1.7
	unicode-width@0.2.0
	unicode-xid@0.2.0
	utf8parse@0.2.2
	vcpkg@0.2.15
	vec_map@0.8.2
	version_check@0.9.2
	wasi@0.11.0+wasi-snapshot-preview1
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-sys@0.36.1
	windows-sys@0.52.0
	windows-sys@0.59.0
	windows-targets@0.52.6
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_msvc@0.36.1
	windows_aarch64_msvc@0.52.6
	windows_i686_gnu@0.36.1
	windows_i686_gnu@0.52.6
	windows_i686_gnullvm@0.52.6
	windows_i686_msvc@0.36.1
	windows_i686_msvc@0.52.6
	windows_x86_64_gnu@0.36.1
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_msvc@0.36.1
	windows_x86_64_msvc@0.52.6"

inherit cargo

DESCRIPTION="A top for NGINX"
HOMEPAGE="https://github.com/gsquire/topngx"
SRC_URI="${CARGO_CRATE_URIS}"

LICENSE="Apache-2.0 Apache-2.0-with-LLVM-exceptions MIT Unlicense"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-db/sqlite:3"

QA_FLAGS_IGNORED="usr/bin/topngx"

src_install() {
	einstalldocs
	cargo_src_install
}
