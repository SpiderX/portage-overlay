# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="Indentation tool for OCaml"
HOMEPAGE="https://github.com/OCamlPro/ocp-indent"
EGIT_REPO_URI="https://github.com/OCamlPro/${PN}.git"

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
IUSE="+ocamlopt"

RDEPEND="dev-ml/cmdliner:0=[ocamlopt?]"
BDEPEND="dev-ml/findlib"
