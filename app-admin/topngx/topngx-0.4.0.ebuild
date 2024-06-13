# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# shellcheck disable=SC2086

EAPI=8

CRATES="ahash@0.7.6
	aho-corasick@0.7.18
	ansi_term@0.11.0
	anyhow@1.0.31
	atty@0.2.14
	autocfg@1.1.0
	bitflags@1.3.2
	cc@1.0.54
	cfg-if@0.1.10
	cfg-if@1.0.0
	clap@2.33.1
	crossbeam-channel@0.5.6
	crossbeam-deque@0.8.2
	crossbeam-epoch@0.9.10
	crossbeam-utils@0.8.11
	crossterm@0.25.0
	crossterm_winapi@0.9.0
	ctrlc@3.2.2
	either@1.5.3
	env_logger@0.9.0
	fallible-iterator@0.2.0
	fallible-streaming-iterator@0.1.9
	getrandom@0.2.7
	hashbrown@0.12.3
	hashlink@0.8.0
	heck@0.3.1
	hermit-abi@0.1.14
	humantime@2.1.0
	lazy_static@1.4.0
	libc@0.2.131
	libsqlite3-sys@0.25.1
	lock_api@0.4.7
	log@0.4.8
	memchr@2.5.0
	memoffset@0.6.5
	mio@0.8.4
	nix@0.24.2
	num_cpus@1.13.0
	once_cell@1.13.0
	parking_lot@0.12.1
	parking_lot_core@0.9.3
	pkg-config@0.3.25
	proc-macro-error@1.0.2
	proc-macro-error-attr@1.0.2
	proc-macro2@1.0.18
	quote@1.0.7
	rayon@1.5.3
	rayon-core@1.9.3
	redox_syscall@0.2.16
	regex@1.6.0
	regex-syntax@0.6.27
	rusqlite@0.28.0
	scopeguard@1.1.0
	signal-hook@0.3.14
	signal-hook-mio@0.2.3
	signal-hook-registry@1.4.0
	smallvec@1.9.0
	strsim@0.8.0
	structopt@0.3.15
	structopt-derive@0.4.8
	syn@1.0.33
	syn-mid@0.5.0
	tabwriter@1.2.1
	termcolor@1.1.0
	textwrap@0.11.0
	topngx@0.4.0
	unicode-segmentation@1.6.0
	unicode-width@0.1.7
	unicode-xid@0.2.0
	vcpkg@0.2.10
	vec_map@0.8.2
	version_check@0.9.2
	wasi@0.11.0+wasi-snapshot-preview1
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.5
	winapi-x86_64-pc-windows-gnu@0.4.0
	windows-sys@0.36.1
	windows_aarch64_msvc@0.36.1
	windows_i686_gnu@0.36.1
	windows_i686_msvc@0.36.1
	windows_x86_64_gnu@0.36.1
	windows_x86_64_msvc@0.36.1"

inherit cargo

DESCRIPTION="A top for NGINX"
HOMEPAGE="https://github.com/gsquire/topngx"
SRC_URI="${CARGO_CRATE_URIS}"

LICENSE="Apache-2.0 Apache-2.0-with-LLVM-exceptions MIT Unlicense"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-db/sqlite:3"

QA_FLAGS_IGNORED="usr/bin/topngx"

src_install() {
	einstalldocs
	cargo_src_install
}
