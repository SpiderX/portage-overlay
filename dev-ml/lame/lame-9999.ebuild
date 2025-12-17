# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="OCaml bindings to lame"
HOMEPAGE="https://github.com/savonet/ocaml-lame"
EGIT_REPO_URI="https://github.com/savonet/ocaml-lame.git"

LICENSE="GPL-2"
SLOT="0/${PV}"
IUSE="+ocamlopt"

RDEPEND="media-sound/lame"
BDEPEND="dev-ml/dune-configurator"
