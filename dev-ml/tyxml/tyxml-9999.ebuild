# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="tyxml tyxml-jsx tyxml-ppx tyxml-syntax"

inherit dune git-r3

DESCRIPTION="A library for building correct HTML and SVG documents"
HOMEPAGE="https://github.com/ocsigen/tyxml"
EGIT_REPO_URI="https://github.com/ocsigen/${PN}.git"

LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/markup:0=[ocamlopt?]
	dev-ml/ppxlib:0=[ocamlopt?]
	dev-ml/seq:0=[ocamlopt?]
	dev-ml/re:0=[ocamlopt?]
	dev-ml/uutf:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest
		dev-ml/reason )"
