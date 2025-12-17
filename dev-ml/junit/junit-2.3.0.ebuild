# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="junit junit_alcotest junit_ounit"

inherit dune

DESCRIPTION="OCaml package to produce JUnit xml reports"
HOMEPAGE="https://github.com/Khady/ocaml-junit"
SRC_URI="https://github.com/Khady/ocaml-${PN}/releases/download/${PV}/${P}.tbz"

LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND=">=dev-ml/alcotest-1.9.0:0=[ocamlopt?]
	dev-ml/ounit2:0=[ocamlopt?]
	dev-ml/ptime:0=[ocamlopt?]
	dev-ml/tyxml:0=[ocamlopt?]"
