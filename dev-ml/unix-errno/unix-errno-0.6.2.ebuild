# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Unix errno types, maps, and support for OCaml"
HOMEPAGE="https://github.com/xapi-project/ocaml-unix-errno"
SRC_URI="https://github.com/xapi-project/ocaml-${PN}/releases/download/${PV}/${P}.tbz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt"

RDEPEND="dev-ml/ocaml-ctypes:0=[ocamlopt?]"
