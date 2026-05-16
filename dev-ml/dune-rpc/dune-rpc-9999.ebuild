# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="dune-rpc"

inherit dune git-r3

DESCRIPTION="Communicate with dune using rpc"
HOMEPAGE="https://github.com/ocaml/dune"
EGIT_REPO_URI="https://github.com/ocaml/dune.git"

LICENSE="MIT"
SLOT="0/${PV}"
IUSE="+ocamlopt"
RESTRICT="test" # tests in main dune package

DEPEND="dev-ml/csexp:0=[ocamlopt?]"
RDEPEND="${DEPEND}
	dev-ml/dune:0=
	dev-ml/dune-private-libs:0=[ocamlopt?]
	dev-ml/ocamlc-loc:0=[ocamlopt?]
	dev-ml/pp:=[ocamlopt?]
	dev-ml/xdg:0=[ocamlopt?]"

src_configure() { :; }

src_compile() {
	dune-compile ${DUNE_PKG_NAME}
}
