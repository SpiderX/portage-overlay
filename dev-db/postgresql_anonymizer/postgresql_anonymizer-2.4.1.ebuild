# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="addr2line@0.24.2
	adler2@2.0.1
	aho-corasick@1.1.3
	aligned-vec@0.6.4
	allocator-api2@0.2.21
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	annotate-snippets@0.11.5
	anstyle@1.0.11
	anyhow@1.0.98
	arbitrary@1.4.1
	arg_enum_proc_macro@0.3.4
	arrayvec@0.7.6
	async-trait@0.1.88
	atomic@0.6.1
	autocfg@1.5.0
	av1-grain@0.2.4
	avif-serialize@0.8.4
	backtrace@0.3.75
	base64@0.22.1
	bigdecimal@0.4.8
	bindgen@0.71.1
	bit-set@0.8.0
	bit-vec@0.8.0
	bit_field@0.10.2
	bitflags@1.3.2
	bitflags@2.9.1
	bitstream-io@2.6.0
	bitvec@1.0.1
	block-buffer@0.10.4
	built@0.7.7
	bumpalo@3.19.0
	bytemuck@1.23.1
	byteorder-lite@0.1.0
	byteorder@1.5.0
	bytes@1.10.1
	c_str_macro@1.0.3
	camino@1.1.10
	cargo-platform@0.1.9
	cargo_metadata@0.18.1
	cargo_toml@0.22.1
	cc@1.2.27
	cee-scape@0.2.0
	cexpr@0.6.0
	cfg-expr@0.15.8
	cfg-if@1.0.1
	chrono@0.4.41
	clang-sys@1.8.1
	clap-cargo@0.14.1
	clap@4.5.40
	clap_builder@4.5.40
	clap_derive@4.5.40
	clap_lex@0.7.5
	codepage@0.1.2
	color_quant@1.1.0
	convert_case@0.8.0
	core-foundation-sys@0.8.7
	cpufeatures@0.2.17
	crc32fast@1.4.2
	crossbeam-deque@0.8.6
	crossbeam-epoch@0.9.18
	crossbeam-utils@0.8.21
	crunchy@0.2.4
	crypto-common@0.1.6
	deranged@0.4.0
	deunicode@1.6.2
	digest@0.10.7
	displaydoc@0.2.5
	either@1.15.0
	encoding_rs@0.8.35
	enum-map-derive@0.17.0
	enum-map@2.7.3
	equator-macro@0.4.2
	equator@0.4.2
	equivalent@1.0.2
	errno@0.3.13
	exr@1.73.0
	eyre@0.6.12
	fake@4.3.0
	fallible-iterator@0.2.0
	fastrand@2.3.0
	fdeflate@0.3.7
	fixedbitset@0.5.7
	flate2@1.1.2
	fnv@1.0.7
	foldhash@0.1.5
	form_urlencoded@1.2.1
	funty@2.0.0
	futures-channel@0.3.31
	futures-core@0.3.31
	futures-macro@0.3.31
	futures-sink@0.3.31
	futures-task@0.3.31
	futures-util@0.3.31
	generic-array@0.14.7
	getrandom@0.2.16
	getrandom@0.3.3
	gif@0.13.3
	gimli@0.31.1
	glob@0.3.2
	half@1.8.3
	half@2.6.0
	hashbrown@0.15.4
	heck@0.5.0
	hermit-abi@0.5.2
	hmac@0.12.1
	home@0.5.11
	http@1.3.1
	iana-time-zone-haiku@0.1.2
	iana-time-zone@0.1.63
	icu_collections@2.0.0
	icu_locale_core@2.0.0
	icu_normalizer@2.0.0
	icu_normalizer_data@2.0.0
	icu_properties@2.0.1
	icu_properties_data@2.0.1
	icu_provider@2.0.0
	idna@1.0.3
	idna_adapter@1.2.1
	image-webp@0.2.3
	image@0.25.6
	imgref@1.11.0
	indenter@0.3.3
	indexmap@2.10.0
	interpolate_name@0.2.4
	is-terminal@0.4.16
	is_ci@1.2.0
	itertools@0.12.1
	itertools@0.13.0
	itoa@1.0.15
	jobserver@0.1.33
	jpeg-decoder@0.3.2
	js-sys@0.3.77
	lazy_static@1.5.0
	lebe@0.5.2
	libc@0.2.174
	libfuzzer-sys@0.4.9
	libloading@0.8.8
	libm@0.2.15
	linux-raw-sys@0.9.4
	litemap@0.8.0
	lock_api@0.4.13
	log@0.4.27
	loop9@0.1.5
	maybe-rayon@0.1.1
	md-5@0.10.6
	memchr@2.7.5
	minimal-lexical@0.2.1
	miniz_oxide@0.8.9
	mio@1.0.4
	new_debug_unreachable@1.0.6
	nom@7.1.3
	noop_proc_macro@0.3.0
	ntapi@0.4.1
	num-bigint@0.4.6
	num-conv@0.1.0
	num-derive@0.4.2
	num-integer@0.1.46
	num-rational@0.4.2
	num-traits@0.2.19
	objc2-core-foundation@0.3.1
	object@0.36.7
	once_cell@1.21.3
	owo-colors@4.2.2
	parking_lot@0.12.4
	parking_lot_core@0.9.11
	paste@1.0.15
	pathsearch@0.2.0
	percent-encoding@2.3.1
	petgraph@0.8.2
	pgrx-bindgen@0.16.0
	pgrx-macros@0.16.0
	pgrx-pg-config@0.16.0
	pgrx-pg-sys@0.16.0
	pgrx-sql-entity-graph@0.16.0
	pgrx-tests@0.16.0
	pgrx@0.16.0
	phf@0.11.3
	phf_shared@0.11.3
	pin-project-lite@0.2.16
	pin-utils@0.1.0
	pkg-config@0.3.32
	png@0.17.16
	postgres-protocol@0.6.8
	postgres-types@0.2.9
	postgres@0.19.10
	potential_utf@0.1.2
	powerfmt@0.2.0
	ppv-lite86@0.2.21
	proc-macro2@1.0.95
	profiling-procmacros@1.0.17
	profiling@1.0.17
	proptest@1.7.0
	qoi@0.4.1
	quick-error@1.2.3
	quick-error@2.0.1
	quote@1.0.40
	r-efi@5.3.0
	radium@0.7.0
	rand@0.8.5
	rand@0.9.1
	rand_chacha@0.3.1
	rand_chacha@0.9.0
	rand_core@0.6.4
	rand_core@0.9.3
	rand_xorshift@0.4.0
	random_color@1.1.0
	rav1e@0.7.1
	ravif@0.11.20
	rayon-core@1.12.1
	rayon@1.10.0
	redox_syscall@0.5.13
	regex-automata@0.4.9
	regex-syntax@0.8.5
	regex@1.11.1
	rgb@0.8.50
	rust_decimal@1.37.2
	rustc-demangle@0.1.25
	rustc-hash@2.1.1
	rustix@1.0.7
	rustversion@1.0.21
	rusty-fork@0.3.0
	ryu@1.0.20
	same-file@1.0.6
	scopeguard@1.2.0
	seahash@4.1.0
	semver@1.0.26
	serde@1.0.219
	serde_cbor@0.11.2
	serde_derive@1.0.219
	serde_json@1.0.140
	serde_spanned@0.6.9
	sha1_smol@1.0.1
	sha2@0.10.9
	shlex@1.3.0
	simd-adler32@0.3.7
	simd_helpers@0.1.0
	siphasher@1.0.1
	slab@0.4.10
	smallvec@1.15.1
	socket2@0.5.10
	sptr@0.3.2
	stable_deref_trait@1.2.0
	stringprep@0.1.5
	subtle@2.6.1
	supports-color@2.1.0
	supports-color@3.0.2
	syn@2.0.104
	synstructure@0.13.2
	sysinfo@0.34.2
	system-deps@6.2.2
	tap@1.0.1
	target-lexicon@0.12.16
	tempfile@3.20.0
	thiserror-impl@1.0.69
	thiserror-impl@2.0.12
	thiserror@1.0.69
	thiserror@2.0.12
	tiff@0.9.1
	time-core@0.1.4
	time-macros@0.2.22
	time@0.3.41
	tinystr@0.8.1
	tinyvec@1.9.0
	tinyvec_macros@0.1.1
	tokio-postgres@0.7.13
	tokio-util@0.7.15
	tokio@1.45.1
	toml@0.8.23
	toml_datetime@0.6.11
	toml_edit@0.22.27
	toml_write@0.1.2
	typenum@1.18.0
	unarray@0.1.4
	unescape@0.1.0
	unicode-bidi@0.3.18
	unicode-ident@1.0.18
	unicode-normalization@0.1.24
	unicode-properties@0.1.3
	unicode-segmentation@1.12.0
	unicode-width@0.2.1
	url-escape@0.1.1
	url@2.5.4
	utf8_iter@1.0.4
	uuid@1.17.0
	v_frame@0.3.9
	version-compare@0.2.0
	version_check@0.9.5
	wait-timeout@0.2.1
	walkdir@2.5.0
	wasi@0.11.1+wasi-snapshot-preview1
	wasi@0.14.2+wasi-0.2.4
	wasite@0.1.0
	wasm-bindgen-backend@0.2.100
	wasm-bindgen-macro-support@0.2.100
	wasm-bindgen-macro@0.2.100
	wasm-bindgen-shared@0.2.100
	wasm-bindgen@0.2.100
	web-sys@0.3.77
	weezl@0.1.10
	whoami@1.6.0
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.9
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-core@0.57.0
	windows-core@0.61.2
	windows-implement@0.57.0
	windows-implement@0.60.0
	windows-interface@0.57.0
	windows-interface@0.59.1
	windows-link@0.1.3
	windows-result@0.1.2
	windows-result@0.3.4
	windows-strings@0.4.2
	windows-sys@0.52.0
	windows-sys@0.59.0
	windows-sys@0.60.2
	windows-targets@0.52.6
	windows-targets@0.53.2
	windows@0.57.0
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
	winnow@0.7.11
	wit-bindgen-rt@0.39.0
	writeable@0.6.1
	wyz@0.5.1
	yoke-derive@0.8.0
	yoke@0.8.0
	zerocopy-derive@0.8.26
	zerocopy@0.8.26
	zerofrom-derive@0.1.6
	zerofrom@0.1.6
	zerotrie@0.2.2
	zerovec-derive@0.11.1
	zerovec@0.11.2
	zune-core@0.4.12
	zune-inflate@0.2.54
	zune-jpeg@0.4.18"
RUST_MIN_VER="1.82.0"
RUST_REQ_USE="rustfmt"
LLVM_COMPAT=( {15..20} )
POSTGRES_COMPAT=( {14..18} )
POSTGRES_USEDEP="server"

inherit cargo edo llvm-r2 postgres

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
BDEPEND="=dev-util/cargo-pgrx-0.16.0*
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

	export PGRX_HOME="${WORKDIR}/${P}"/.pgrx
	edo cargo pgrx init --pg"${PG_SLOT}" "${PG_CONFIG}"
}

src_compile() {
	emake extension PGVER=pg"${PG_SLOT}"
}

src_test() {
	emake test PGVER=pg"${PG_SLOT}"
}

src_install() {
	einstalldocs

	local PG_PKGLIBDIR PG_SHAREDIR
	PG_PKGLIBDIR="$($PG_CONFIG --libdir)"
	PG_SHAREDIR="$($PG_CONFIG --sharedir)"

	dodir "${PG_SHAREDIR}"/extension "${PG_PKGLIBDIR}"
	emake install PGVER=pg"${PG_SLOT}" \
		PG_SHAREDIR="${ED}/${PG_SHAREDIR}" \
		TARGET_SHAREDIR="target/release/anon-pg${PG_SLOT}/${PG_SHAREDIR}" \
		PG_PKGLIBDIR="${ED}/${PG_PKGLIBDIR}" \
		TARGET_PKGLIBDIR="target/release/anon-pg${PG_SLOT}/${PG_PKGLIBDIR}"
}
