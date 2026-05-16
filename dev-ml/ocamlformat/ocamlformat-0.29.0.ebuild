# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="ocamlformat ocamlformat-bench ocamlformat-lib ocamlformat-rpc-lib"

inherit dune

DESCRIPTION="Auto-formatter for OCaml code"
HOMEPAGE="https://github.com/ocaml-ppx/ocamlformat"
SRC_URI="https://github.com/ocaml-ppx/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

DEPEND="dev-ml/csexp:0=[ocamlopt?]"
RDEPEND="${DEPEND}
	dev-ml/astring:0=
	dev-ml/base:0=[ocamlopt?]
	dev-ml/bechamel:0=[ocamlopt?]
	dev-ml/camlp-streams:=[ocamlopt?]
	dev-ml/cmdliner:0=[ocamlopt?]
	dev-ml/dune-build-info:0=[ocamlopt?]
	dev-ml/either:0=[ocamlopt?]
	dev-ml/fpath:0=
	dev-ml/menhir:0=[ocamlopt?]
	dev-ml/ocaml-version:0=[ocamlopt?]
	dev-ml/ocp-indent:0=[ocamlopt?]
	dev-ml/re:0=[ocamlopt?]
	dev-ml/uuseg:0=[ocamlopt?]
	dev-ml/uutf:0=[ocamlopt?]
	dev-ml/yojson:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest )"
