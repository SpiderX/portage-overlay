# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="Embed typed ASN.1 grammars in OCaml"
HOMEPAGE="https://github.com/mirleft/ocaml-asn1-combinators"
EGIT_REPO_URI="https://github.com/mirleft/ocaml-asn1-combinators.git"

LICENSE="ISC"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/ptime:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest
		dev-ml/ohex )"
