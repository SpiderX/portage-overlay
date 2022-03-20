# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="srt"

inherit dune

DESCRIPTION="OCaml bindings for Secure, Reliable, Transport protocol library"
HOMEPAGE="https://github.com/savonet/ocaml-srt"
SRC_URI="https://github.com/savonet/${PN}/archive/v${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt"

RDEPEND="dev-ml/ocaml-ctypes:=[ocamlopt?]
	dev-ml/ocaml-posix:=[ocamlopt?]
	net-libs/srt"
BDEPEND="dev-ml/dune-configurator:0=
	virtual/pkgconfig"
