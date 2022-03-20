# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="alsa"

inherit dune

DESCRIPTION="OCaml bindings to alsa-lib"
HOMEPAGE="https://github.com/savonet/ocaml-alsa"
SRC_URI="https://github.com/savonet/${PN}/archive/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt"

RDEPEND="media-libs/alsa-lib"
BDEPEND="dev-ml/dune-configurator:=
	virtual/pkgconfig"
