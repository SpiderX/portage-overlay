# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="arbitrary@1.3.2
	cc@1.0.97
	compiler_builtins@0.1.111
	jobserver@0.1.31
	libc@0.2.154
	libfuzzer-sys@0.4.7
	once_cell@1.19.0
	rustc-std-workspace-core@1.0.0"

inherit cargo

DESCRIPTION="Library for Rust symbol demangling"
HOMEPAGE="https://github.com/rust-lang/rustc-demangle"
SRC_URI="https://github.com/rust-lang/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}"

LICENSE="Apache-2.0 MIT"
SLOT="0"
KEYWORDS="~amd64"

QA_FLAGS_IGNORED="usr/lib64/librustc_demangle.so"

src_compile() {
	pushd crates/capi
	cargo_src_compile
	popd
}

src_install() {
	einstalldocs
	doheader crates/capi/include/rustc_demangle.h
	dolib.a target/release/librustc_demangle.a
	dolib.so target/release/librustc_demangle.so
}
