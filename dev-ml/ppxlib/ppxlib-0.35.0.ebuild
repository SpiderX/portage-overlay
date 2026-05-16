# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="ppxlib ppxlib-bench ppxlib-tools"

inherit dune

DESCRIPTION="Base library and tools for ppx rewriters"
HOMEPAGE="https://github.com/ocaml-ppx/ppxlib"
SRC_URI="https://github.com/ocaml-ppx/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~arm ~arm64 ~riscv ~x86"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

PDEPEND="dev-ml/yojson" # circular
RDEPEND="<dev-lang/ocaml-5.4:0=[ocamlopt?]
	dev-ml/cmdliner:0=[ocamlopt?]
	dev-ml/ocaml-compiler-libs:=[ocamlopt?]
	dev-ml/ppx_derivers:=[ocamlopt?]
	dev-ml/sexplib0:0=[ocamlopt?]
	dev-ml/stdlib-shims:=[ocamlopt?]"
DEPEND="${RDEPEND}"
BDEPEND="test? ( dev-ml/cinaps
		dev-ml/findlib
		dev-ml/re )"
