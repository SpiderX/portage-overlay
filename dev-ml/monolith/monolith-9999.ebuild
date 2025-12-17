# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="A framework for strong random testing of OCaml libraries"
HOMEPAGE="https://gitlab.inria.fr/fpottier/monolith"
EGIT_REPO_URI="https://gitlab.inria.fr/fpottier/${PN}.git"

LICENSE="LGPL-3"
SLOT="0/${PV}"
IUSE="+ocamlopt"

RDEPEND="dev-ml/afl-persistent:0=[ocamlopt?]
	dev-ml/pprint:0=[ocamlopt?]"
