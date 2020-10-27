# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/ocaml-community/${PN}.git"

inherit dune git-r3

DESCRIPTION="Low-level JSON parsing and pretty-printing library for OCaml"
HOMEPAGE="https://github.com/ocaml-community/yojson"
SRC_URI=""

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS=""
IUSE="+ocamlopt test"
RESTRICT="test" #jbuilder

RDEPEND="dev-lang/ocaml:=[ocamlopt?]
	dev-ml/biniou:=[ocamlopt?]
	dev-ml/easy-format:=[ocamlopt?]"
BDEPEND="${RDEPEND}
	>=dev-ml/cppo-1.6.6:=[ocamlopt?]
	dev-ml/dune:=
	test? ( dev-ml/alcotest:= )"

DOCS=( {CHANGES,README}.md )
