# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="pyro-caml pyro-caml-instruments pyro-caml-ppx"
RUST_MIN_VER="1.87.0"

inherit cargo dune git-r3

DESCRIPTION="A statistical continuous profiler for OCaml"
HOMEPAGE="https://github.com/semgrep/pyro-caml"
EGIT_REPO_URI="https://github.com/semgrep/${PN}.git"

LICENSE="Apache-2.0 BSD CDLA-Permissive-2.0 ISC MIT Unicode-3.0 ZLIB"
SLOT="0/${PV}"
IUSE="+ocamlopt"

RDEPEND="dev-ml/logs:0=[ocamlopt?]
	dev-ml/ppx_deriving:0=[ocamlopt?]
	>=dev-ml/ppxlib-0.36.0:0=[ocamlopt?]
	|| ( dev-lang/rust dev-lang/rust-bin )"

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}

src_prepare() {
	default

	sed -i "/pyroscope = {/s|git = .*|path = \"${WORKDIR}/pyroscope-rs-0235912a5eb5fd87d47d9c0d386c47b03c29e7ff\" }|" \
		Cargo.toml || die "sed failed for Cargo.toml"
}

src_compile() {
	cargo_src_compile
	dune-compile ${DUNE_PKG_NAME}
}

src_test() {
	cargo_src_test
	dune-test ${DUNE_PKG_NAME}
}

src_install() {
	cargo_src_install
	dune_src_install
}
