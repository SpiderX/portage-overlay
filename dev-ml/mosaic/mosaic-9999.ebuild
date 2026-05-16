# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="matrix matrix-eio mosaic toffee tree-sitter"

inherit dune git-r3

DESCRIPTION="Terminal user interfaces for OCaml"
HOMEPAGE="https://github.com/invariant-hq/mosaic"
EGIT_REPO_URI="https://github.com/invariant-hq/${PN}.git"

LICENSE="ISC"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="test" # needs windtrap, which needs ppxlib-0.37

RDEPEND=">=dev-lang/ocaml-5.1:0=[ocamlopt?]
	dev-ml/cmarkit:0=[ocamlopt?]
	dev-ml/eio:0=[ocamlopt?]"

src_prepare() {
	default

	# doesn't exist before ocaml 5.4
	sed -i 's/Sys\.sigwinch/28/g' matrix/lib/matrix.ml \
		matrix-eio/lib/matrix_eio.ml \
		|| die "sed failed"
}

src_compile() {
	dune-compile ${DUNE_PKG_NAME}
}

src_test() {
	dune-test ${DUNE_PKG_NAME}
}
