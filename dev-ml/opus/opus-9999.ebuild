# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="OCaml bindings to opus"
HOMEPAGE="https://github.com/savonet/ocaml-opus"
EGIT_REPO_URI="https://github.com/savonet/ocaml-opus.git"

LICENSE="GPL-2"
SLOT="0/${PV}"
IUSE="+ocamlopt"

RDEPEND="!dev-ml/xiph
	dev-ml/ogg:0=[ocamlopt?]
	media-libs/opus"
BDEPEND="dev-ml/dune-configurator
	virtual/pkgconfig"
