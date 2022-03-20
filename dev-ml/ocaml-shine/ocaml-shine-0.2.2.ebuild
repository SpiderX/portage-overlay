# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="shine"

inherit dune

DESCRIPTION="OCaml bindings to libshine"
HOMEPAGE="https://github.com/savonet/ocaml-shine"
SRC_URI="https://github.com/savonet/${PN}/archive/v${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt"

RDEPEND="media-libs/shine"
BDEPEND="dev-ml/dune-configurator:0=
	virtual/pkgconfig"
