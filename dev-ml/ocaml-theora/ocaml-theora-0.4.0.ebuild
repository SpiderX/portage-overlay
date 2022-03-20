# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="theora"

inherit dune

DESCRIPTION="OCaml bindings to libtheora"
HOMEPAGE="https://github.com/savonet/ocaml-theora"
SRC_URI="https://github.com/savonet/${PN}/archive/v${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt"

RDEPEND="dev-ml/ocaml-ogg:=[ocamlopt?]
	media-libs/libtheora"
BDEPEND="dev-ml/dune-configurator:0=
	virtual/pkgconfig"
