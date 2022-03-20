# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="fdkaac"

inherit dune

DESCRIPTION="OCaml bindings to fdk-aac"
HOMEPAGE="https://github.com/savonet/ocaml-fdkaac"
SRC_URI="https://github.com/savonet/${PN}/archive/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt"

RDEPEND="media-libs/fdk-aac:="
BDEPEND="dev-ml/dune-configurator:0="
