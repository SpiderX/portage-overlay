# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

MY_PN="ocaml-${PN}"

DESCRIPTION="OCaml bindings to flac"
HOMEPAGE="https://github.com/savonet/ocaml-flac"
SRC_URI="https://github.com/savonet/${MY_PN}/archive/v${PV}/${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="GPL-2"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt ogg"

RDEPEND="!dev-ml/xiph
	media-libs/flac:0=[ogg?]
	ogg? ( dev-ml/ogg:0=[ocamlopt?] )"
BDEPEND="dev-ml/dune-configurator
	virtual/pkgconfig"
