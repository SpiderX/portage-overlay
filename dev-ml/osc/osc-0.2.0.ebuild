# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# osc-lwt needs lwt < 2.7
DUNE_PKG_NAME="osc osc-unix"

inherit dune

MY_PN="ocaml-${PN}"

DESCRIPTION="Pure OCaml implementation of the Open Sound Control protocol"
HOMEPAGE="https://github.com/johnelse/ocaml-osc"
SRC_URI="https://github.com/johnelse/${MY_PN}/archive/${PN}.${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PN}.${PV}"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt"
RESTRICT="test" # dev-ml/ounit2 doesn't have ounit

RDEPEND="dev-ml/ocplib-endian:0=[ocamlopt?]"

src_compile() {
	dune-compile ${DUNE_PKG_NAME}
}
