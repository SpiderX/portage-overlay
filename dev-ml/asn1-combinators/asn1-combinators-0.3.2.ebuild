# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Embed typed ASN.1 grammars in OCaml"
HOMEPAGE="https://github.com/mirleft/ocaml-asn1-combinators"
SRC_URI="https://github.com/mirleft/ocaml-${PN}/releases/download/v${PV}/${P}.tbz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/ptime:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest
		dev-ml/ohex )"
