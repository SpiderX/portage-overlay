# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="OCaml bindings to liblo"
HOMEPAGE="https://github.com/savonet/ocaml-lo"
EGIT_REPO_URI="https://github.com/savonet/ocaml-lo.git"

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
IUSE="+ocamlopt"

RDEPEND="media-libs/liblo"
BDEPEND="dev-ml/dune-configurator"
