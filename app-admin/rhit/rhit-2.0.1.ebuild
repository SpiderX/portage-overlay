# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# shellcheck disable=SC2086

EAPI=8

CRATES="adler@1.0.2
	ahash@0.4.7
	aho-corasick@1.0.4
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	anstream@0.5.0
	anstyle@1.0.2
	anstyle-parse@0.2.1
	anstyle-query@1.0.0
	anstyle-wincon@2.1.0
	anyhow@1.0.75
	argh@0.1.12
	argh_derive@0.1.12
	argh_shared@0.1.12
	arrayvec@0.7.4
	autocfg@1.1.0
	base64@0.13.1
	bet@1.0.2
	bitflags@1.3.2
	bitflags@2.4.0
	bumpalo@3.13.0
	cc@1.0.83
	cfg-if@1.0.0
	chrono@0.4.26
	clap@4.4.0
	clap-help@1.0.0
	clap_builder@4.4.0
	clap_derive@4.4.0
	clap_lex@0.5.1
	cli-log@2.0.0
	colorchoice@1.0.0
	coolor@0.5.0
	core-foundation-sys@0.8.4
	crc32fast@1.3.2
	crossbeam@0.8.2
	crossbeam-channel@0.5.8
	crossbeam-deque@0.8.3
	crossbeam-epoch@0.9.15
	crossbeam-queue@0.3.8
	crossbeam-utils@0.8.16
	crossterm@0.23.2
	crossterm_winapi@0.9.1
	csv@1.2.2
	csv-core@0.1.10
	csv2svg@0.1.9
	directories-next@2.0.0
	dirs-sys-next@0.1.2
	either@1.9.0
	errno@0.3.2
	errno-dragonfly@0.1.2
	fallible-iterator@0.2.0
	fallible-streaming-iterator@0.1.9
	fastrand@2.0.0
	file-size@1.0.3
	flate2@1.0.27
	form_urlencoded@1.2.0
	getrandom@0.2.10
	git2@0.14.4
	glassbench@0.3.5
	hashbrown@0.9.1
	hashlink@0.6.0
	have@0.1.1
	heck@0.4.1
	iana-time-zone@0.1.57
	iana-time-zone-haiku@0.1.2
	idna@0.4.0
	itertools@0.11.0
	itoa@1.0.9
	jobserver@0.1.26
	js-sys@0.3.64
	lazy-regex@3.0.1
	lazy-regex-proc_macros@3.0.1
	lazy_static@1.4.0
	libc@0.2.147
	libgit2-sys@0.13.5+1.4.5
	libsqlite3-sys@0.20.1
	libz-sys@1.1.12
	linux-raw-sys@0.4.5
	lock_api@0.4.10
	log@0.4.20
	memchr@2.5.0
	memoffset@0.6.5
	memoffset@0.9.0
	minimad@0.9.1
	minimad@0.13.0
	miniz_oxide@0.7.1
	mio@0.8.8
	nix@0.22.3
	num-format@0.4.4
	num-traits@0.2.16
	once_cell@1.18.0
	open@1.7.1
	parking_lot@0.12.1
	parking_lot_core@0.9.8
	pathdiff@0.2.1
	percent-encoding@2.3.0
	pkg-config@0.3.27
	proc-macro2@1.0.66
	proc-status@0.1.1
	quote@1.0.33
	redox_syscall@0.2.16
	redox_syscall@0.3.5
	redox_users@0.4.3
	regex@1.9.4
	regex-automata@0.3.7
	regex-syntax@0.7.5
	rhit@2.0.1
	rusqlite@0.24.2
	rustix@0.38.9
	ryu@1.0.15
	scopeguard@1.2.0
	serde@1.0.188
	serde_derive@1.0.188
	serde_json@1.0.105
	signal-hook@0.3.17
	signal-hook-mio@0.2.3
	signal-hook-registry@1.4.1
	smallvec@1.11.0
	strsim@0.10.0
	svg@0.13.1
	syn@2.0.29
	tempfile@3.8.0
	termimad@0.20.6
	termimad@0.25.1
	terminal-light@1.1.1
	thiserror@1.0.47
	thiserror-impl@1.0.47
	time@0.1.45
	tinyvec@1.6.0
	tinyvec_macros@0.1.1
	unicode-bidi@0.3.13
	unicode-ident@1.0.11
	unicode-normalization@0.1.22
	unicode-width@0.1.10
	url@2.4.0
	utf8parse@0.2.1
	vcpkg@0.2.15
	wasi@0.10.0+wasi-snapshot-preview1
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen@0.2.87
	wasm-bindgen-backend@0.2.87
	wasm-bindgen-macro@0.2.87
	wasm-bindgen-macro-support@0.2.87
	wasm-bindgen-shared@0.2.87
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-x86_64-pc-windows-gnu@0.4.0
	windows@0.48.0
	windows-sys@0.48.0
	windows-targets@0.48.5
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_msvc@0.48.5
	windows_i686_gnu@0.48.5
	windows_i686_msvc@0.48.5
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_msvc@0.48.5
	xterm-query@0.2.0"

inherit cargo

DESCRIPTION="A nginx log explorer"
HOMEPAGE="https://github.com/Canop/rhit"
SRC_URI="${CARGO_CRATE_URIS}"

LICENSE="0BSD Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD Boost-1.0 MIT Unicode-DFS-2016 Unlicense ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DOCS=( {CHANGELOG,README}.md )

QA_PREBUILT="usr/bin/rhit"

src_install() {
	einstalldocs
	cargo_src_install
}
