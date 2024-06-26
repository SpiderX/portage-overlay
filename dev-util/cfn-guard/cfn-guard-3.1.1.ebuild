# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# shellcheck disable=SC2086

EAPI=8

CRATES="Inflector@0.11.4
	aho-corasick@0.7.20
	aho-corasick@1.1.2
	anstream@0.6.11
	anstyle@1.0.6
	anstyle-parse@0.2.3
	anstyle-query@1.0.2
	anstyle-wincon@3.0.2
	anyhow@1.0.81
	arrayvec@0.5.2
	async-stream@0.3.3
	async-stream-impl@0.3.3
	atty@0.2.14
	autocfg@1.1.0
	bit-set@0.5.3
	bit-vec@0.6.3
	bitflags@1.3.2
	bstr@1.2.0
	bytecount@0.6.3
	bytes@1.4.0
	cfg-if@1.0.0
	cfn-guard@3.1.1
	clap@4.5.0
	clap_builder@4.5.0
	clap_complete@4.1.2
	clap_derive@4.5.0
	clap_lex@0.7.0
	colorchoice@1.0.0
	colored@2.0.0
	diff@0.1.13
	encoding_rs@0.8.32
	encoding_rs_io@0.1.7
	enumflags2@0.7.7
	enumflags2_derive@0.7.7
	fancy-regex@0.13.0
	ffi-support@0.4.4
	fnv@1.0.7
	futures@0.3.26
	futures-channel@0.3.26
	futures-core@0.3.26
	futures-executor@0.3.26
	futures-io@0.3.26
	futures-macro@0.3.26
	futures-sink@0.3.26
	futures-task@0.3.26
	futures-timer@3.0.2
	futures-util@0.3.26
	grep-matcher@0.1.6
	grep-regex@0.1.11
	grep-searcher@0.1.11
	hashbrown@0.12.3
	heck@0.3.3
	heck@0.4.1
	hermit-abi@0.1.19
	hermit-abi@0.2.6
	http@0.2.8
	http-body@0.4.5
	httparse@1.8.0
	httpdate@1.0.2
	hyper@0.14.24
	indexmap@1.9.2
	indoc@1.0.9
	itertools@0.4.19
	itoa@1.0.5
	lambda_runtime@0.3.0
	lazy_static@1.4.0
	lexical-core@0.7.6
	libc@0.2.153
	log@0.4.17
	memchr@2.6.4
	memmap2@0.5.8
	mio@0.8.11
	nom@5.1.3
	nom_locate@2.1.0
	num_cpus@1.15.0
	num_threads@0.1.6
	once_cell@1.17.0
	pin-project-lite@0.2.9
	pin-utils@0.1.0
	pretty_assertions@1.4.0
	proc-macro2@1.0.78
	quick-xml@0.30.0
	quote@1.0.35
	regex@1.10.2
	regex-automata@0.1.10
	regex-automata@0.4.3
	regex-syntax@0.6.28
	regex-syntax@0.8.2
	rstest@0.15.0
	rstest_macros@0.14.0
	rustc_version@0.4.0
	ryu@1.0.12
	same-file@1.0.6
	semver@1.0.16
	serde@1.0.197
	serde_derive@1.0.197
	serde_json@1.0.93
	serde_yaml@0.9.17
	sharded-slab@0.1.4
	simple_logger@4.0.0
	slab@0.4.7
	socket2@0.4.7
	static_assertions@1.1.0
	string-builder@0.2.0
	strip-ansi-escapes@0.1.1
	strsim@0.11.0
	syn@1.0.107
	syn@2.0.55
	thiserror@1.0.38
	thiserror-impl@1.0.38
	thread_local@1.1.4
	time@0.3.17
	time-core@0.1.0
	time-macros@0.2.6
	tokio@1.25.0
	tokio-macros@1.8.2
	tokio-stream@0.1.11
	tower-service@0.3.2
	tracing@0.1.37
	tracing-attributes@0.1.23
	tracing-core@0.1.30
	tracing-error@0.1.2
	tracing-subscriber@0.2.25
	try-lock@0.2.4
	unicode-ident@1.0.6
	unicode-segmentation@1.10.1
	unsafe-libyaml@0.2.10
	urlencoding@2.1.2
	utf8parse@0.2.1
	valuable@0.1.0
	version_check@0.9.4
	vte@0.10.1
	vte_generate_state_changes@0.1.1
	walkdir@2.3.2
	want@0.3.0
	wasi@0.11.0+wasi-snapshot-preview1
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.5
	winapi-x86_64-pc-windows-gnu@0.4.0
	windows-sys@0.42.0
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-targets@0.48.5
	windows-targets@0.52.0
	windows_aarch64_gnullvm@0.42.1
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.0
	windows_aarch64_msvc@0.42.1
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.0
	windows_i686_gnu@0.42.1
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.0
	windows_i686_msvc@0.42.1
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.0
	windows_x86_64_gnu@0.42.1
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.0
	windows_x86_64_gnullvm@0.42.1
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.0
	windows_x86_64_msvc@0.42.1
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.0
	yansi@0.5.1"

inherit cargo

DESCRIPTION="AWS CloudFormation Guard"
HOMEPAGE="https://github.com/aws-cloudformation/cloudformation-guard"
SRC_URI="${CARGO_CRATE_URIS}"

LICENSE="Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD BSD-2 Boost-1.0 MIT MPL-2.0 Unicode-DFS-2016 Unlicense"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="mirror"

QA_FLAGS_IGNORED="usr/bin/cfn-guard"

src_install() {
	einstalldocs
	cargo_src_install
}
