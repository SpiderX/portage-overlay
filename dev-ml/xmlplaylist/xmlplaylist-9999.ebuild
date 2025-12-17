# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="OCaml module to parse various RSS playlist formats"
HOMEPAGE="https://github.com/savonet/ocaml-xmlplaylist"
EGIT_REPO_URI="https://github.com/savonet/ocaml-xmlplaylist.git"

LICENSE="GPL-2"
SLOT="0/${PV}"
IUSE="+ocamlopt"

RDEPEND="dev-ml/xmlm:0="
