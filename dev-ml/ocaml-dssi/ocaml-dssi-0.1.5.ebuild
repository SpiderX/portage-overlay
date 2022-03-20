# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="dssi"

inherit dune

DESCRIPTION="OCaml bindings to dssi"
HOMEPAGE="https://github.com/savonet/ocaml-dssi"
SRC_URI="https://github.com/savonet/${PN}/archive/v${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt"

RDEPEND="media-libs/dssi
	dev-ml/ocaml-ladspa:=[ocamlopt?]"
BDEPEND="dev-ml/dune-configurator:0="
