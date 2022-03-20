# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="mad"

inherit dune

DESCRIPTION="OCaml bindings to libmad"
HOMEPAGE="https://github.com/savonet/ocaml-mad"
SRC_URI="https://github.com/savonet/${PN}/archive/v${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt"

RDEPEND="media-libs/libmad"
BDEPEND="dev-ml/dune-configurator:=
	virtual/pkgconfig"
