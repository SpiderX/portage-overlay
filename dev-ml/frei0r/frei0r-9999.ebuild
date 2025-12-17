# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="frei0r"

inherit dune git-r3

DESCRIPTION="OCaml bindings to frei0r plugins"
HOMEPAGE="https://github.com/savonet/ocaml-frei0r"
EGIT_REPO_URI="https://github.com/savonet/ocaml-frei0r.git"

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
IUSE="+ocamlopt"

RDEPEND="media-plugins/frei0r-plugins"
BDEPEND="dev-ml/dune-configurator
	virtual/pkgconfig"
