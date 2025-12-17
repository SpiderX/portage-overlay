# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Experimental model checker for testing concurrent algorithms"
HOMEPAGE="https://github.com/ocaml-multicore/dscheck"
SRC_URI="https://github.com/ocaml-multicore/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND=">=dev-lang/ocaml-5:0=
	dev-ml/cmdliner:0=[ocamlopt?]
	dev-ml/containers:0=[ocamlopt?]
	dev-ml/oseq:0=[ocamlopt?]
	dev-ml/seq[ocamlopt?]
	dev-ml/tsort:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest )"
