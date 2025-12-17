# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="Experimental model checker for testing concurrent algorithms"
HOMEPAGE="https://github.com/ocaml-multicore/dscheck"
EGIT_REPO_URI="https://github.com/ocaml-multicore/${PN}.git"

LICENSE="ISC"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/cmdliner:0=[ocamlopt?]
	dev-ml/containers:0=[ocamlopt?]
	dev-ml/oseq:0=[ocamlopt?]
	dev-ml/seq[ocamlopt?]
	dev-ml/tsort:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest )"
