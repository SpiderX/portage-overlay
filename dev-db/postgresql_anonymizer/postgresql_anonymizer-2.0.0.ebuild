# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# shellcheck disable=SC2016

EAPI=8

CRATES="addr2line@0.24.1
	adler2@2.0.0
	aho-corasick@1.1.3
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	annotate-snippets@0.9.2
	anstyle@1.0.8
	anyhow@1.0.89
	arrayvec@0.7.6
	async-trait@0.1.82
	atomic-traits@0.3.0
	atomic@0.6.0
	autocfg@1.3.0
	backtrace@0.3.74
	base64@0.22.1
	bigdecimal@0.4.5
	bindgen@0.70.1
	bit-set@0.5.3
	bit-vec@0.6.3
	bitflags@2.6.0
	bitvec@1.0.1
	block-buffer@0.10.4
	bumpalo@3.16.0
	bytemuck@1.18.0
	byteorder@1.5.0
	bytes@1.7.2
	c_str_macro@1.0.3
	camino@1.1.9
	cargo-platform@0.1.8
	cargo_metadata@0.18.1
	cargo_toml@0.19.2
	cc@1.1.21
	cee-scape@0.2.0
	cexpr@0.6.0
	cfg-if@1.0.0
	chrono@0.4.38
	clang-sys@1.8.1
	clap-cargo@0.14.1
	clap@4.5.17
	clap_builder@4.5.17
	clap_derive@4.5.13
	clap_lex@0.7.2
	convert_case@0.6.0
	core-foundation-sys@0.8.7
	cpufeatures@0.2.14
	crossbeam-deque@0.8.5
	crossbeam-epoch@0.9.18
	crossbeam-utils@0.8.20
	crypto-common@0.1.6
	deranged@0.3.11
	deunicode@1.6.0
	digest@0.10.7
	either@1.13.0
	enum-map-derive@0.17.0
	enum-map@2.7.3
	equivalent@1.0.1
	errno@0.3.9
	eyre@0.6.12
	fake@2.10.0
	fallible-iterator@0.2.0
	fastrand@2.1.1
	fixedbitset@0.4.2
	fnv@1.0.7
	form_urlencoded@1.2.1
	funty@2.0.0
	futures-channel@0.3.30
	futures-core@0.3.30
	futures-macro@0.3.30
	futures-sink@0.3.30
	futures-task@0.3.30
	futures-util@0.3.30
	generic-array@0.14.7
	getrandom@0.2.15
	gimli@0.31.0
	glob@0.3.1
	half@1.8.3
	hash32@0.3.1
	hashbrown@0.14.5
	heapless@0.8.0
	heck@0.5.0
	hermit-abi@0.3.9
	hermit-abi@0.4.0
	hmac@0.12.1
	home@0.5.9
	http@1.1.0
	iana-time-zone-haiku@0.1.2
	iana-time-zone@0.1.61
	idna@0.5.0
	indenter@0.3.3
	indexmap@2.5.0
	is-terminal@0.4.13
	is_ci@1.2.0
	itertools@0.13.0
	itoa@1.0.11
	js-sys@0.3.70
	lazy_static@1.5.0
	libc@0.2.158
	libloading@0.8.5
	libm@0.2.8
	linux-raw-sys@0.4.14
	lock_api@0.4.12
	log@0.4.22
	md-5@0.10.6
	memchr@2.7.4
	minimal-lexical@0.2.1
	miniz_oxide@0.8.0
	mio@1.0.2
	nom@7.1.3
	ntapi@0.4.1
	num-bigint@0.4.6
	num-conv@0.1.0
	num-integer@0.1.46
	num-traits@0.2.19
	object@0.36.4
	once_cell@1.19.0
	owo-colors@4.1.0
	parking_lot@0.12.3
	parking_lot_core@0.9.10
	paste@1.0.15
	pathsearch@0.2.0
	percent-encoding@2.3.1
	pest@2.7.13
	petgraph@0.6.5
	pgrx-bindgen@0.12.9
	pgrx-macros@0.12.9
	pgrx-pg-config@0.12.9
	pgrx-pg-sys@0.12.9
	pgrx-sql-entity-graph@0.12.9
	pgrx-tests@0.12.9
	pgrx@0.12.9
	phf@0.11.2
	phf_shared@0.11.2
	pin-project-lite@0.2.14
	pin-utils@0.1.0
	postgres-protocol@0.6.7
	postgres-types@0.2.8
	postgres@0.19.9
	powerfmt@0.2.0
	ppv-lite86@0.2.20
	proc-macro2@1.0.86
	proptest@1.5.0
	quick-error@1.2.3
	quote@1.0.37
	radium@0.7.0
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	rand_xorshift@0.3.0
	random_color@0.8.0
	rayon-core@1.12.1
	rayon@1.10.0
	redox_syscall@0.5.4
	regex-automata@0.4.7
	regex-syntax@0.8.4
	regex@1.10.6
	rust_decimal@1.36.0
	rustc-demangle@0.1.24
	rustc-hash@1.1.0
	rustc_version@0.3.3
	rustix@0.38.37
	rusty-fork@0.3.0
	ryu@1.0.18
	same-file@1.0.6
	scopeguard@1.2.0
	seahash@4.1.0
	semver-parser@0.10.2
	semver@0.11.0
	semver@1.0.23
	serde@1.0.210
	serde_cbor@0.11.2
	serde_derive@1.0.210
	serde_json@1.0.128
	serde_spanned@0.6.7
	sha1_smol@1.0.1
	sha2@0.10.8
	shlex@1.3.0
	siphasher@0.3.11
	slab@0.4.9
	smallvec@1.13.2
	socket2@0.5.7
	sptr@0.3.2
	stable_deref_trait@1.2.0
	stringprep@0.1.5
	subtle@2.6.1
	supports-color@2.1.0
	supports-color@3.0.1
	syn@2.0.77
	sysinfo@0.30.13
	tap@1.0.1
	tempfile@3.12.0
	thiserror-impl@1.0.63
	thiserror@1.0.63
	time-core@0.1.2
	time-macros@0.2.18
	time@0.3.36
	tinyvec@1.8.0
	tinyvec_macros@0.1.1
	tokio-postgres@0.7.12
	tokio-util@0.7.12
	tokio@1.40.0
	toml@0.8.19
	toml_datetime@0.6.8
	toml_edit@0.22.21
	typenum@1.17.0
	ucd-trie@0.1.6
	unarray@0.1.4
	unescape@0.1.0
	unicode-bidi@0.3.15
	unicode-ident@1.0.13
	unicode-normalization@0.1.24
	unicode-properties@0.1.2
	unicode-segmentation@1.12.0
	unicode-width@0.1.14
	url-escape@0.1.1
	url@2.5.2
	uuid@1.10.0
	version_check@0.9.5
	wait-timeout@0.2.0
	walkdir@2.5.0
	wasi@0.11.0+wasi-snapshot-preview1
	wasite@0.1.0
	wasm-bindgen-backend@0.2.93
	wasm-bindgen-macro-support@0.2.93
	wasm-bindgen-macro@0.2.93
	wasm-bindgen-shared@0.2.93
	wasm-bindgen@0.2.93
	web-sys@0.3.70
	whoami@1.5.2
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.9
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-core@0.52.0
	windows-sys@0.52.0
	windows-sys@0.59.0
	windows-targets@0.52.6
	windows@0.52.0
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_msvc@0.52.6
	windows_i686_gnu@0.52.6
	windows_i686_gnullvm@0.52.6
	windows_i686_msvc@0.52.6
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_msvc@0.52.6
	winnow@0.6.18
	wyz@0.5.1
	yansi-term@0.1.2
	zerocopy-derive@0.7.35
	zerocopy@0.7.35"
RUST_REQ_USE="rustfmt"
LLVM_COMPAT=( {15..19} )
POSTGRES_COMPAT=( {12..17} )
POSTGRES_USEDEP="server"

inherit cargo llvm-r2 postgres

DESCRIPTION="Anonymization & Data Masking for PostgreSQL"
HOMEPAGE="https://gitlab.com/dalibo/postgresql_anonymizer"
SRC_URI="https://gitlab.com/dalibo/${PN}/-/archive/${PV}/${P}.tar.bz2
	${CARGO_CRATE_URIS}"

LICENSE="Apache-2.0 BSD ISC MIT POSTGRESQL Unicode-DFS-2016"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${POSTGRES_REQ_USE} ${LLVM_REQUIRED_USE}"
RESTRICT="test" # installs extension outside of sandbox

RDEPEND="${POSTGRES_DEP}"
BDEPEND="=dev-util/cargo-pgrx-0.12.9*
	virtual/pkgconfig
	$(llvm_gen_dep 'llvm-core/clang:${LLVM_SLOT}')"

DOCS=( {CHANGELOG,NEWS,README}.md )

QA_FLAGS_IGNORED="usr/lib.*/postgresql-.*/lib.*/anon.so"

pkg_setup() {
	llvm-r2_pkg_setup
	postgres_pkg_setup
	rust_pkg_setup
}

src_prepare() {
	default

	# fix warnings (https://github.com/pgcentralfoundation/pgrx/issues/1966)
	sed -i  -e '/pg12/s|#||' \
		-e '$a\\n[lints.rust]' \
		-e '$aunexpected_cfgs = { level = "warn", check-cfg = ["cfg(pgrx_embed)"] }' \
		Cargo.toml || die "sed failed"

	export PGRX_HOME="${WORKDIR}/${P}"/.pgrx
	cargo pgrx init --pg"${PG_SLOT}" "${PG_CONFIG}" || die "cargo pgrx failed"
}

src_compile() {
	emake extension PGVER=pg"${PG_SLOT}"
}

src_test() {
	emake test PGVER=pg"${PG_SLOT}"
}

src_install() {
	einstalldocs

	local PG_LIBDIR PG_SHAREDIR
	PG_LIBDIR="$($PG_CONFIG --libdir)"
	PG_SHAREDIR="$($PG_CONFIG --sharedir)"

	dodir "${PG_SHAREDIR}"/extension "${PG_LIBDIR}"
	emake install PGVER=pg"${PG_SLOT}" \
		PG_SHAREDIR="${ED}/${PG_SHAREDIR}" \
		TARGET_SHAREDIR="target/release/anon-pg${PG_SLOT}/${PG_SHAREDIR}" \
		PG_LIBDIR="${ED}/${PG_LIBDIR}" \
		TARGET_LIBDIR="target/release/anon-pg${PG_SLOT}/${PG_LIBDIR}"
}
