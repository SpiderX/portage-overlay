# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

MY_PN="ocaml-${PN}"

DESCRIPTION="OCaml bindings for Secure, Reliable, Transport protocol library"
HOMEPAGE="https://github.com/savonet/ocaml-srt"
SRC_URI="https://github.com/savonet/${MY_PN}/archive/v${PV}/${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="GPL-2"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt"

RDEPEND="dev-ml/ocaml-ctypes:0=[ocamlopt?]
	dev-ml/posix-socket:0=[ocamlopt?]
	net-libs/srt:0="
BDEPEND="dev-ml/dune-configurator
	virtual/pkgconfig"
