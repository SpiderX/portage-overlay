# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="A implementation of OCaml's visitors"
HOMEPAGE="https://github.com/semgrep/semgrep-ocaml-visitors"
EGIT_REPO_URI="https://github.com/semgrep/semgrep-ocaml-visitors.git"

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="test" # fails

RDEPEND="<dev-ml/ppxlib-0.37:0=[ocamlopt?]
	dev-ml/ppx_deriving_yojson:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest
		dev-ml/qcheck )"
