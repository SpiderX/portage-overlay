# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="uri uri-bench uri-sexp uri-re"

inherit dune edo git-r3

DESCRIPTION="An RFC3986 URI/URL parsing library"
HOMEPAGE="https://github.com/mirage/ocaml-uri"
EGIT_REPO_URI="https://github.com/mirage/ocaml-uri.git"

LICENSE="ISC"
SLOT="0"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/angstrom:0=[ocamlopt?]
	dev-ml/re:0=[ocamlopt?]
	dev-ml/sexplib0:0=[ocamlopt?]
	dev-ml/stringext:0=[ocamlopt?]
	dev-ml/textutils:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/core_bench
		dev-ml/core_unix
		dev-ml/crowbar
		dev-ml/ounit2
		dev-ml/ppx_sexp_conv )"

src_prepare() {
	default

	# remove fuzzers
	edo rm -rf fuzz
}
