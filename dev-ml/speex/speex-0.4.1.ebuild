# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

MY_PN="ocaml-${PN}"

DESCRIPTION="OCaml bindings to speex"
HOMEPAGE="https://github.com/savonet/ocaml-speex"
SRC_URI="https://github.com/savonet/${MY_PN}/archive/v${PV}/${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="GPL-2"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt"

RDEPEND="!dev-ml/xiph
	dev-ml/ogg:0=[ocamlopt?]
	media-libs/speex"
BDEPEND="dev-ml/dune-configurator
	virtual/pkgconfig"
