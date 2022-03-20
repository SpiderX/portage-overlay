# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="lilv"

inherit dune

DESCRIPTION="OCaml bindings to lilv"
HOMEPAGE="https://github.com/savonet/ocaml-lilv"
SRC_URI="https://github.com/savonet/${PN}/archive/v${PV}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt"

RDEPEND="dev-ml/ocaml-ctypes:=[ocamlopt?]
	media-libs/lilv"
BDEPEND="dev-ml/dune-configurator:0=
	virtual/pkgconfig"
