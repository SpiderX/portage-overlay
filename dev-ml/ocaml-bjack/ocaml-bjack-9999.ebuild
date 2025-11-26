# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="bjack"

inherit dune git-r3

DESCRIPTION="OCaml blocking JACK API"
HOMEPAGE="https://github.com/savonet/ocaml-bjack"
EGIT_REPO_URI="https://github.com/savonet/${PN}.git"

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
IUSE="+ocamlopt"

RDEPEND="media-libs/libsamplerate
	virtual/jack"
BDEPEND="dev-ml/dune-configurator:0=
	virtual/pkgconfig"
