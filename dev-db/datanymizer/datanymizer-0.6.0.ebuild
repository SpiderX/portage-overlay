# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# shellcheck disable=SC2086

EAPI=8

CRATES="ahash@0.7.4
	aho-corasick@0.7.18
	ansi_term@0.11.0
	anyhow@1.0.33
	async-trait@0.1.56
	atty@0.2.14
	autocfg@1.0.1
	base64@0.13.0
	bcrypt@0.12.1
	bitflags@1.2.1
	block-buffer@0.7.3
	block-buffer@0.9.0
	block-padding@0.1.5
	blowfish@0.9.1
	bstr@0.2.14
	byte-tools@0.3.1
	byteorder@1.3.4
	bytes@1.0.1
	cc@1.0.71
	cfg-if@0.1.10
	cfg-if@1.0.0
	cipher@0.4.3
	clap@2.33.3
	cloudabi@0.1.0
	config@0.13.1
	console@0.13.0
	core-foundation@0.9.2
	core-foundation-sys@0.8.3
	cpufeatures@0.1.4
	crossbeam-utils@0.8.8
	crypto-common@0.1.3
	crypto-mac@0.10.0
	csv@1.1.3
	csv-core@0.1.10
	deunicode@0.4.3
	digest@0.8.1
	digest@0.9.0
	dlv-list@0.3.0
	dtoa@0.4.6
	encode_unicode@0.3.6
	env_logger@0.9.0
	fake@2.4.1
	fake-simd@0.1.2
	fallible-iterator@0.2.0
	fnv@1.0.7
	foreign-types@0.3.2
	foreign-types-shared@0.1.1
	form_urlencoded@1.0.0
	futures@0.3.17
	futures-channel@0.3.17
	futures-core@0.3.17
	futures-executor@0.3.17
	futures-io@0.3.17
	futures-macro@0.3.17
	futures-sink@0.3.17
	futures-task@0.3.17
	futures-util@0.3.17
	generic-array@0.12.4
	generic-array@0.14.4
	getrandom@0.2.2
	globset@0.4.8
	globwalk@0.8.1
	hashbrown@0.12.1
	heck@0.3.1
	hermit-abi@0.1.17
	hmac@0.10.1
	humansize@1.1.1
	humantime@2.1.0
	idna@0.2.0
	ignore@0.4.18
	indicatif@0.15.0
	inout@0.1.3
	instant@0.1.8
	itoa@0.4.6
	itoa@1.0.1
	json5@0.4.1
	lazy_static@1.4.0
	libc@0.2.117
	linked-hash-map@0.5.3
	lock_api@0.4.6
	log@0.4.17
	maplit@1.0.2
	matches@0.1.8
	md-5@0.9.1
	memchr@2.5.0
	minimal-lexical@0.2.1
	mio@0.7.11
	miow@0.3.7
	native-tls@0.2.8
	nom@7.1.1
	ntapi@0.3.6
	num_threads@0.1.3
	number_prefix@0.3.0
	once_cell@1.5.2
	opaque-debug@0.2.3
	opaque-debug@0.3.0
	openssl@0.10.36
	openssl-probe@0.1.4
	openssl-sys@0.9.67
	ordered-multimap@0.4.3
	parking_lot@0.11.0
	parking_lot_core@0.8.0
	parse-zoneinfo@0.3.0
	pathdiff@0.2.1
	percent-encoding@2.1.0
	pest@2.1.3
	pest_derive@2.1.0
	pest_generator@2.1.3
	pest_meta@2.1.3
	phf@0.8.0
	phf@0.10.1
	phf_codegen@0.10.0
	phf_generator@0.10.0
	phf_shared@0.8.0
	phf_shared@0.10.0
	pin-project-lite@0.2.6
	pin-utils@0.1.0
	pkg-config@0.3.22
	postgres@0.19.1
	postgres-native-tls@0.5.0
	postgres-protocol@0.6.1
	postgres-types@0.2.1
	ppv-lite86@0.2.9
	proc-macro-error@1.0.4
	proc-macro-error-attr@1.0.4
	proc-macro-hack@0.5.19
	proc-macro-nested@0.1.6
	proc-macro2@1.0.39
	quote@1.0.7
	rand@0.8.4
	rand_chacha@0.3.0
	rand_core@0.6.2
	rand_hc@0.3.0
	redox_syscall@0.1.57
	redox_syscall@0.2.10
	regex@1.5.6
	regex-automata@0.1.9
	regex-syntax@0.6.26
	remove_dir_all@0.5.3
	ron@0.7.0
	rust-ini@0.18.0
	ryu@1.0.5
	same-file@1.0.6
	schannel@0.1.19
	scopeguard@1.1.0
	security-framework@2.3.1
	security-framework-sys@2.4.2
	serde@1.0.137
	serde-xml-rs@0.5.1
	serde_derive@1.0.137
	serde_json@1.0.59
	serde_yaml@0.8.14
	sha-1@0.8.2
	sha2@0.9.5
	siphasher@0.3.3
	slab@0.4.2
	slug@0.1.4
	smallvec@1.6.1
	socket2@0.4.0
	solvent@0.8.2
	stringprep@0.1.2
	strsim@0.8.0
	structopt@0.3.20
	structopt-derive@0.4.13
	subtle@2.3.0
	syn@1.0.96
	tempfile@3.2.0
	tera@1.15.0
	termcolor@1.1.3
	terminal_size@0.1.13
	textwrap@0.11.0
	thiserror@1.0.22
	thiserror-impl@1.0.22
	thread_local@1.1.4
	time@0.3.7
	time-macros@0.2.3
	time-tz@1.0.2
	tinyvec@0.3.4
	tokio@1.16.1
	tokio-native-tls@0.3.0
	tokio-postgres@0.7.2
	tokio-util@0.6.6
	toml@0.5.7
	typenum@1.15.0
	ucd-trie@0.1.3
	unic-char-property@0.9.0
	unic-char-range@0.9.0
	unic-common@0.9.0
	unic-segment@0.9.0
	unic-ucd-segment@0.9.0
	unic-ucd-version@0.9.0
	unicode-bidi@0.3.4
	unicode-ident@1.0.0
	unicode-normalization@0.1.13
	unicode-segmentation@1.7.0
	unicode-width@0.1.8
	url@2.2.0
	uuid@1.1.2
	vcpkg@0.2.15
	vec_map@0.8.2
	version_check@0.9.2
	walkdir@2.3.1
	wasi@0.10.0+wasi-snapshot-preview1
	wildmatch@2.1.0
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.5
	winapi-x86_64-pc-windows-gnu@0.4.0
	xml-rs@0.8.4
	yaml-rust@0.4.4
	zeroize@1.5.4"

inherit cargo

DESCRIPTION="Powerful database anonymizer with flexible rules"
HOMEPAGE="https://github.com/datanymizer/datanymizer"
SRC_URI="https://github.com/datanymizer/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}"

LICENSE="Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD BSD-2 Boost-1.0 ISC MIT Unlicense ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DOCS=( {CHANGELOG,README}.md )

QA_FLAGS_IGNORED="usr/bin/pg_datanymizer"

src_prepare() {
	default

	# use tera crate from registry
	sed -i '/tera#/s|".*|"registry+https://github.com/rust-lang/crates.io-index"|' \
		Cargo.lock || die "sed failed for Cargo.lock"
	sed -i '/tera/s|git = "https://github.com/datanymizer/tera"|version = "1.15.0"|' \
		datanymizer_engine/Cargo.toml || die "sed failed for Cargo.toml"
}

src_compile() {
	cargo_src_compile --package pg_datanymizer
}

src_install() {
	einstalldocs
	cargo_src_install --path cli/pg_datanymizer
}
