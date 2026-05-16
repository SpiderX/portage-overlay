# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="alcotest-lwt"

inherit dune

DESCRIPTION="A lightweight and colourful test framework"
HOMEPAGE="https://github.com/mirage/alcotest"
SRC_URI="https://github.com/mirage/alcotest/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/alcotest-${PV}"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/cmdliner:0=[ocamlopt?]
	dev-ml/fmt:0=[ocamlopt?]
	dev-ml/logs:0=[ocamlopt?]
	dev-ml/lwt:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/re )"

src_compile() {
	dune-compile ${DUNE_PKG_NAME}
}

src_test() {
	dune-test ${DUNE_PKG_NAME}
}
