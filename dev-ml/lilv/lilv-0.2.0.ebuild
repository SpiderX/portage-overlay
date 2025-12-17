# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

MY_PN="ocaml-${PN}"

DESCRIPTION="OCaml bindings to lilv"
HOMEPAGE="https://github.com/savonet/ocaml-lilv"
SRC_URI="https://github.com/savonet/${MY_PN}/archive/v${PV}/${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt"

RDEPEND="dev-ml/ocaml-ctypes:0=[ocamlopt?]
	media-libs/lilv"
BDEPEND="dev-ml/dune-configurator
	virtual/pkgconfig"

PATCHES=( "${FILESDIR}/${PN}"-0.2.0-types.patch )
