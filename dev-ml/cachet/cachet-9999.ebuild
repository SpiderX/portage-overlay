# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# cachet-solo5 needs mirage-solo5
DUNE_PKG_NAME="cachet cachet-lwt"

inherit dune git-r3

DESCRIPTION="A simple cache system for mmap in OCaml"
HOMEPAGE="https://github.com/robur-coop/cachet"
EGIT_REPO_URI="https://github.com/robur-coop/${PN}.git"

LICENSE="ISC"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/bstr:0=[ocamlopt?]
	dev-ml/lwt:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest
		dev-ml/crowbar
		dev-ml/fmt
		dev-ml/hxd
		dev-ml/logs
		dev-ml/ohex )"

src_compile() {
	dune-compile ${DUNE_PKG_NAME}
}

src_test() {
	dune-test ${DUNE_PKG_NAME}
}
