# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# shellcheck disable=SC2086

EAPI=8

CRATES="
	aho-corasick-0.7.12
	ansi_term-0.11.0
	anyhow-1.0.31
	arc-swap-0.4.7
	atty-0.2.14
	autocfg-1.0.0
	bitflags-1.2.1
	cc-1.0.54
	cfg-if-0.1.10
	clap-2.33.1
	cloudabi-0.0.3
	crossbeam-channel-0.4.2
	crossbeam-deque-0.7.3
	crossbeam-epoch-0.8.2
	crossbeam-queue-0.2.3
	crossbeam-utils-0.7.2
	crossterm-0.17.5
	crossterm_winapi-0.6.1
	ctrlc-3.1.4
	either-1.5.3
	env_logger-0.7.1
	fallible-iterator-0.2.0
	fallible-streaming-iterator-0.1.9
	fuchsia-zircon-0.3.3
	fuchsia-zircon-sys-0.3.3
	heck-0.3.1
	hermit-abi-0.1.14
	humantime-1.3.0
	iovec-0.1.4
	kernel32-sys-0.2.2
	lazy_static-1.4.0
	libc-0.2.71
	libsqlite3-sys-0.18.0
	linked-hash-map-0.5.3
	lock_api-0.3.4
	log-0.4.8
	lru-cache-0.1.2
	maybe-uninit-2.0.0
	memchr-2.3.3
	memoffset-0.5.4
	mio-0.6.22
	miow-0.2.1
	net2-0.2.34
	nix-0.17.0
	num_cpus-1.13.0
	once_cell-1.4.0
	parking_lot-0.10.2
	parking_lot_core-0.7.2
	pkg-config-0.3.17
	proc-macro-error-1.0.2
	proc-macro-error-attr-1.0.2
	proc-macro2-1.0.18
	quick-error-1.2.3
	quote-1.0.7
	rayon-1.3.1
	rayon-core-1.7.1
	redox_syscall-0.1.56
	regex-1.3.9
	regex-syntax-0.6.18
	rusqlite-0.23.1
	scopeguard-1.1.0
	signal-hook-0.1.16
	signal-hook-registry-1.2.0
	slab-0.4.2
	smallvec-1.4.0
	strsim-0.8.0
	structopt-0.3.15
	structopt-derive-0.4.8
	syn-1.0.33
	syn-mid-0.5.0
	tabwriter-1.2.1
	termcolor-1.1.0
	textwrap-0.11.0
	thread_local-1.0.1
	time-0.1.43
	unicode-segmentation-1.6.0
	unicode-width-0.1.7
	unicode-xid-0.2.0
	vcpkg-0.2.10
	vec_map-0.8.2
	version_check-0.9.2
	void-1.0.2
	winapi-0.2.8
	winapi-0.3.8
	winapi-build-0.1.1
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
	ws2_32-sys-0.2.1
"
EGIT_REPO_URI="https://github.com/gsquire/${PN}.git"

inherit cargo git-r3

DESCRIPTION="A top for NGINX"
HOMEPAGE="https://github.com/gsquire/topngx"
SRC_URI="$(cargo_crate_uris ${CRATES})"

LICENSE="MIT"
KEYWORDS=""
SLOT="0"

RDEPEND="dev-db/sqlite:3"

QA_FLAGS_IGNORED="usr/bin/topngx"

src_unpack() {
	git-r3_src_unpack
	cargo_src_unpack
}
