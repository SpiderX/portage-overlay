# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=maturin
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{11..14} )

CRATES="atomic@0.6.0
	autocfg@1.1.0
	bitflags@2.5.0
	block-buffer@0.10.4
	bumpalo@3.19.0
	bytemuck@1.16.1
	cc@1.0.83
	cfg-if@1.0.0
	cfg_aliases@0.2.1
	crypto-common@0.1.6
	digest@0.10.7
	generic-array@0.14.7
	getrandom@0.3.2
	heck@0.5.0
	indoc@2.0.5
	js-sys@0.3.77
	libc@0.2.171
	log@0.4.27
	mac_address@1.1.8
	md-5@0.10.6
	memoffset@0.9.0
	nix@0.29.0
	once_cell@1.18.0
	portable-atomic@1.6.0
	ppv-lite86@0.2.17
	proc-macro2@1.0.86
	pyo3-build-config@0.25.1
	pyo3-ffi@0.25.1
	pyo3-macros-backend@0.25.1
	pyo3-macros@0.25.1
	pyo3@0.25.1
	python3-dll-a@0.2.13
	quote@1.0.36
	r-efi@5.2.0
	rand@0.9.1
	rand_chacha@0.9.0
	rand_core@0.9.3
	rustversion@1.0.21
	sha1_smol@1.0.0
	syn@2.0.68
	target-lexicon@0.13.2
	typenum@1.17.0
	unicode-ident@1.0.12
	unindent@0.2.3
	uuid@1.17.0
	version_check@0.9.4
	wasi@0.14.2+wasi-0.2.4
	wasm-bindgen-backend@0.2.100
	wasm-bindgen-macro-support@0.2.100
	wasm-bindgen-macro@0.2.100
	wasm-bindgen-shared@0.2.100
	wasm-bindgen@0.2.100
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	wit-bindgen-rt@0.39.0"

inherit cargo distutils-r1 pypi

DESCRIPTION="Python bindings to Rust UUID"
HOMEPAGE="https://github.com/aminalaee/uuid-utils"
SRC_URI+="
	${CARGO_CRATE_URIS}
"

LICENSE="Apache-2.0-with-LLVM-exceptions BSD MIT Unicode-DFS-2016"
SLOT="0"
KEYWORDS="~amd64"

QA_FLAGS_IGNORED="usr/lib/python3.*/site-packages/uuid_utils/_uuid_utils.abi3.so"

distutils_enable_tests pytest
