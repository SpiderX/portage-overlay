# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="ocplib-json-typed ocplib-json-typed-browser ocplib-json-typed-bson"

inherit dune edo git-r3

DESCRIPTION="Libraries for reliable manipulation JSON objects"
HOMEPAGE="https://github.com/OCamlPro/ocplib-json-typed"
EGIT_REPO_URI="https://github.com/OCamlPro/${PN}.git"

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
IUSE="+ocamlopt"

RDEPEND="dev-ml/js_of_ocaml:0=[ocamlopt?]
	dev-ml/ocplib-endian:0=[ocamlopt?]
	dev-ml/uri:0=[ocamlopt?]"

src_prepare() {
	default

	edo echo "(lang dune 3.20)" > dune-project
}

src_compile() {
	dune-compile ${DUNE_PKG_NAME}
}
