# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit dune

DESCRIPTION="OCaml bindings to libmad"
HOMEPAGE="https://github.com/savonet/ocaml-mad"
SRC_URI="https://github.com/savonet/${PN}/archive/v${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt"

RDEPEND="dev-lang/ocaml:=[ocamlopt?]
	media-libs/libmad"
BDEPEND="${RDEPEND}
	dev-ml/dune:=
	dev-ml/dune-configurator:=[ocamlopt?]"

DOCS=( CHANGES README )

src_install() {
	dune_src_install mad
}
