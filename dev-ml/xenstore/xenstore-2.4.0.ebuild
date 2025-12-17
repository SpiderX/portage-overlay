# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Xenstore protocol in pure OCaml"
HOMEPAGE="https://github.com/mirage/ocaml-xenstore"
SRC_URI="https://github.com/mirage/ocaml-${PN}/releases/download/${PV}/${P}.tbz"

LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/lwt:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/ounit2 )"
