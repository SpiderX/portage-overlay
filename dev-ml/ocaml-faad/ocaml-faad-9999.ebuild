# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="faad"

inherit dune git-r3

DESCRIPTION="OCaml bindings to faad2"
HOMEPAGE="https://github.com/savonet/ocaml-faad"
EGIT_REPO_URI="https://github.com/savonet/${PN}.git"

LICENSE="GPL-2"
SLOT="0/${PV}"
IUSE="+ocamlopt"

RDEPEND="media-libs/faad2"
