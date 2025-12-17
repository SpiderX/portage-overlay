# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="OCaml bindings to dssi"
HOMEPAGE="https://github.com/savonet/ocaml-dssi"
EGIT_REPO_URI="https://github.com/savonet/ocaml-dssi.git"

LICENSE="GPL-2"
SLOT="0/${PV}"
IUSE="+ocamlopt"

RDEPEND="dev-ml/ladspa:0=[ocamlopt?]
	media-libs/dssi"
BDEPEND="dev-ml/dune-configurator"
