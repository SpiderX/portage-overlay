# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="OCaml bindings to taglib"
HOMEPAGE="https://github.com/savonet/ocaml-taglib"
EGIT_REPO_URI="https://github.com/savonet/ocaml-taglib.git"

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
IUSE="+ocamlopt"

RDEPEND="<=media-libs/taglib-2"
BDEPEND="dev-ml/dune-configurator
	virtual/pkgconfig"
