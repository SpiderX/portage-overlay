# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Bindings to io_uring for OCaml"
HOMEPAGE="https://github.com/ocaml-multicore/ocaml-uring"
SRC_URI="https://github.com/ocaml-multicore/ocaml-${PN}/releases/download/v${PV}/${P}.tbz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

DEPEND=">=sys-libs/liburing-2.15"
RDEPEND="${RDEPEND}
	dev-ml/bechamel:0=[ocamlopt?]
	dev-ml/cmdliner:0=[ocamlopt?]
	>=dev-ml/cstruct-6.3.0:0=[ocamlopt?]
	dev-ml/fmt:0=[ocamlopt?]
	dev-ml/logs:0=[ocamlopt?]
	dev-ml/lwt:0=[ocamlopt?]
	dev-ml/mdx:0=[ocamlopt?]
	dev-ml/optint:0=[ocamlopt?]"
BDEPEND="dev-ml/dune-configurator
	test? ( dev-ml/alcotest )"

PATCHES=( "${FILESDIR}/${PN}"-2.15.0-system-libs.patch )
