# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# osc-lwt needs lwt < 2.7
DUNE_PKG_NAME="osc osc-unix"

inherit dune git-r3

DESCRIPTION="Pure OCaml implementation of the Open Sound Control protocol"
HOMEPAGE="https://github.com/johnelse/ocaml-osc"
EGIT_REPO_URI="https://github.com/johnelse/ocaml-osc.git"

LICENSE="MIT"
SLOT="0/${PV}"
IUSE="+ocamlopt"
RESTRICT="test" # dev-ml/ounit2 doesn't have ounit

RDEPEND="dev-ml/ocplib-endian:0=[ocamlopt?]"

src_compile() {
	dune-compile ${DUNE_PKG_NAME}
}
