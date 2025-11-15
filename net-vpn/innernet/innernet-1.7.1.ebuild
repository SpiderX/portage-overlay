# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="addr2line@0.24.2
	adler2@2.0.1
	ahash@0.8.12
	aho-corasick@1.1.3
	allocator-api2@0.2.21
	anstream@0.6.20
	anstyle-parse@0.2.7
	anstyle-query@1.1.4
	anstyle-wincon@3.0.10
	anstyle@1.0.11
	anyhow@1.0.99
	atty@0.2.14
	autocfg@1.5.0
	backtrace@0.3.75
	base64@0.13.1
	base64@0.22.1
	bindgen@0.72.0
	bitflags@1.3.2
	bitflags@2.9.1
	byteorder@1.5.0
	bytes@1.10.1
	cc@1.2.32
	cexpr@0.6.0
	cfg-if@1.0.1
	cfg_aliases@0.2.1
	clang-sys@1.8.1
	clap@4.5.44
	clap_builder@4.5.44
	clap_complete@4.5.57
	clap_derive@4.5.41
	clap_lex@0.7.5
	colorchoice@1.0.4
	colored@2.2.0
	console@0.15.11
	cpufeatures@0.2.17
	curve25519-dalek-derive@0.1.1
	curve25519-dalek@4.1.3
	dialoguer@0.11.0
	displaydoc@0.2.5
	dunce@1.0.5
	either@1.15.0
	encode_unicode@1.0.0
	env_logger@0.7.1
	equivalent@1.0.2
	errno@0.3.13
	fallible-iterator@0.2.0
	fallible-streaming-iterator@0.1.9
	fastrand@2.3.0
	fiat-crypto@0.2.9
	fnv@1.0.7
	form_urlencoded@1.2.1
	futures-channel@0.3.31
	futures-core@0.3.31
	futures-task@0.3.31
	futures-util@0.3.31
	getrandom@0.2.16
	getrandom@0.3.3
	gimli@0.31.1
	glob@0.3.3
	hashbrown@0.14.5
	hashbrown@0.15.5
	hashlink@0.8.4
	heck@0.5.0
	hermit-abi@0.1.19
	hex@0.4.3
	http-body@0.4.6
	http@0.2.12
	httparse@1.10.1
	httpdate@1.0.3
	humantime@1.3.0
	hyper@0.14.32
	hostsfile@1.7.1
	icu_collections@2.0.0
	icu_locale_core@2.0.0
	icu_normalizer@2.0.0
	icu_normalizer_data@2.0.0
	icu_properties@2.0.1
	icu_properties_data@2.0.1
	icu_provider@2.0.0
	idna@1.0.3
	idna_adapter@1.2.1
	indexmap@2.10.0
	indoc@2.0.6
	innernet-publicip@1.7.1
	innernet-shared@1.7.1
	io-uring@0.7.9
	ipnet@2.11.0
	is_terminal_polyfill@1.70.1
	itertools@0.13.0
	itoa@1.0.15
	lazy_static@1.5.0
	libc@0.2.175
	libloading@0.8.8
	libsqlite3-sys@0.26.0
	linux-raw-sys@0.9.4
	litemap@0.8.0
	lock_api@0.4.13
	log@0.4.27
	memchr@2.7.5
	memoffset@0.6.5
	memoffset@0.7.1
	memoffset@0.9.1
	minimal-lexical@0.2.1
	miniz_oxide@0.8.9
	mio@1.0.4
	netlink-packet-core@0.7.0
	netlink-packet-generic@0.3.3
	netlink-packet-route@0.21.0
	netlink-packet-utils@0.5.2
	netlink-packet-wireguard@0.2.3
	netlink-request@1.7.1
	netlink-sys@0.8.7
	nix@0.25.1
	nix@0.26.4
	nix@0.30.1
	nom@7.1.3
	object@0.36.7
	once_cell@1.21.3
	once_cell_polyfill@1.70.1
	parking_lot@0.12.4
	parking_lot_core@0.9.11
	paste@1.0.15
	percent-encoding@2.3.1
	pin-project-lite@0.2.16
	pin-utils@0.1.0
	pkg-config@0.3.32
	potential_utf@0.1.2
	pretty_env_logger@0.4.0
	prettyplease@0.2.36
	proc-macro2@1.0.97
	quick-error@1.2.3
	quote@1.0.40
	r-efi@5.3.0
	rand_core@0.6.4
	redox_syscall@0.5.17
	reference-counted-singleton@0.1.5
	regex-automata@0.4.9
	regex-syntax@0.8.5
	regex@1.11.1
	rusqlite@0.29.0
	rustc-demangle@0.1.26
	rustc-hash@2.1.1
	rustc_version@0.4.1
	rustix@1.0.8
	ryu@1.0.20
	same-file@1.0.6
	scopeguard@1.2.0
	selinux-sys@0.6.15
	selinux@0.4.6
	semver@1.0.26
	serde@1.0.219
	serde_derive@1.0.219
	serde_json@1.0.142
	serde_spanned@0.6.9
	shell-words@1.1.0
	shlex@1.3.0
	slab@0.4.11
	smallvec@1.15.1
	socket2@0.5.10
	socket2@0.6.0
	stable_deref_trait@1.2.0
	strsim@0.11.1
	subtle@2.6.1
	syn@2.0.104
	synstructure@0.13.2
	tempfile@3.20.0
	termcolor@1.4.1
	terminal_size@0.4.3
	thiserror-impl@1.0.69
	thiserror@1.0.69
	tinystr@0.8.1
	tokio-macros@2.5.0
	tokio@1.47.1
	toml@0.8.23
	toml_datetime@0.6.11
	toml_edit@0.22.27
	toml_write@0.1.2
	tower-service@0.3.3
	tracing-core@0.1.34
	tracing@0.1.41
	try-lock@0.2.5
	unicode-ident@1.0.18
	unicode-width@0.2.1
	ureq@2.12.1
	url@2.5.4
	utf8_iter@1.0.4
	utf8parse@0.2.2
	vcpkg@0.2.15
	version_check@0.9.5
	walkdir@2.5.0
	want@0.3.1
	wasi@0.11.1+wasi-snapshot-preview1
	wasi@0.14.2+wasi-0.2.4
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.9
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-link@0.1.3
	windows-sys@0.52.0
	windows-sys@0.59.0
	windows-sys@0.60.2
	windows-targets@0.52.6
	windows-targets@0.53.3
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_gnullvm@0.53.0
	windows_aarch64_msvc@0.52.6
	windows_aarch64_msvc@0.53.0
	windows_i686_gnu@0.52.6
	windows_i686_gnu@0.53.0
	windows_i686_gnullvm@0.52.6
	windows_i686_gnullvm@0.53.0
	windows_i686_msvc@0.52.6
	windows_i686_msvc@0.53.0
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnu@0.53.0
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_gnullvm@0.53.0
	windows_x86_64_msvc@0.52.6
	windows_x86_64_msvc@0.53.0
	winnow@0.7.12
	wit-bindgen-rt@0.39.0
	wireguard-control@1.7.1
	writeable@0.6.1
	x25519-dalek@2.0.1
	yoke-derive@0.8.0
	yoke@0.8.0
	zerocopy-derive@0.8.26
	zerocopy@0.8.26
	zerofrom-derive@0.1.6
	zerofrom@0.1.6
	zeroize@1.8.1
	zeroize_derive@1.4.2
	zerotrie@0.2.2
	zerovec-derive@0.11.1
	zerovec@0.11.4"
RUST_MIN_VER="1.85.0"

inherit cargo pax-utils shell-completion systemd

DESCRIPTION="A private network system that uses WireGuard"
HOMEPAGE="https://github.com/tonarino/innernet"
SRC_URI="https://github.com/tonarino/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}"

LICENSE="Apache-2.0 BSD ISC MIT MPL-2.0 Unicode-3.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+client server"
REQUIRED_USE="|| ( client server )"

RDEPEND="server? ( dev-db/sqlite:3
		virtual/zlib:0= )"

QA_PREBUILT="usr/bin/innernet
	/usr/bin/innernet-server"

src_compile() {
	use client && cargo_src_compile --bin innernet
	use server && cargo_src_compile --bin innernet-server
}

src_install() {
	if use client ; then
		doman doc/innernet.8
		newbashcomp doc/innernet.completions.bash innernet
		newfishcomp doc/innernet.completions.fish innernet
		newzshcomp doc/innernet.completions.zsh _innernet
		dobin target/release/innernet
		pax-mark m "${ED}"/usr/bin/innernet
		dosym ../bin/innernet usr/bin/inn
		newinitd "${FILESDIR}"/innernet-client.initd innernet-client
		newconfd "${FILESDIR}"/innernet-client.confd innernet-client
		systemd_dounit client/innernet@.service
	fi
	if use server ; then
		doman doc/innernet-server.8
		newbashcomp doc/innernet-server.completions.bash innernet-server
		newfishcomp doc/innernet-server.completions.fish innernet-server
		newzshcomp doc/innernet-server.completions.zsh _innernet-server
		dobin target/release/innernet-server
		pax-mark m "${ED}"/usr/bin/innernet-server
		newinitd "${FILESDIR}"/innernet-server.initd innernet-server
		newconfd "${FILESDIR}"/innernet-server.confd innernet-server
		systemd_dounit server/innernet-server@.service
	fi
}
