# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="frei0r"

inherit dune

DESCRIPTION="OCaml bindings to frei0r plugins"
HOMEPAGE="https://github.com/savonet/ocaml-frei0r"
SRC_URI="https://github.com/savonet/${PN}/archive/v${PV}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt"

RDEPEND="media-plugins/frei0r-plugins"
BDEPEND="dev-ml/dune-configurator:0=
	virtual/pkgconfig"
