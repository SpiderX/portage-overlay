# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="data-encoding json-data-encoding json-data-encoding-browser
	json-data-encoding-bson"

inherit dune git-r3

DESCRIPTION="Type-safe encoding to and decoding from JSON"
HOMEPAGE="https://gitlab.com/nomadic-labs/data-encoding"
EGIT_REPO_URI="https://gitlab.com/nomadic-labs/${PN}.git"

LICENSE="MIT"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/bigstringaf[ocamlopt?]
	dev-ml/either:0=[ocamlopt?]
	dev-ml/ezjsonm:0=[ocamlopt?]
	dev-ml/hex:0=[ocamlopt?]
	dev-ml/ocplib-endian:0=[ocamlopt?]
	dev-ml/ppx_expect:0=[ocamlopt?]
	dev-ml/ppx_hash:0=[ocamlopt?]
	dev-ml/uri[ocamlopt?]
	dev-ml/zarith[ocamlopt?]
	dev-ml/zarith_stubs_js:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest
		dev-ml/crowbar
		dev-ml/js_of_ocaml
		dev-ml/md2mld )"

PATCHES=( "${FILESDIR}/${PN}"-1.0.1-test.patch )
