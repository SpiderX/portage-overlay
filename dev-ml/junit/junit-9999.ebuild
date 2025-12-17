# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="junit junit_alcotest junit_ounit"

inherit dune git-r3

DESCRIPTION="OCaml package to produce JUnit xml reports"
HOMEPAGE="https://github.com/Khady/ocaml-junit"
EGIT_REPO_URI="https://github.com/Khady/ocaml-junit.git"

LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND=">=dev-ml/alcotest-1.9.0:0=[ocamlopt?]
	dev-ml/ounit2:0=[ocamlopt?]
	dev-ml/ptime:0=[ocamlopt?]
	dev-ml/tyxml:0=[ocamlopt?]"
