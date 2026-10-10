# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

COMMIT="6efca08b2a98317b1d705c1e88b8342ec558205c"

DESCRIPTION="OCaml bindings to backward-cpp"
HOMEPAGE="https://github.com/semgrep/obackward"
SRC_URI="https://github.com/semgrep/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

RDEPEND="app-arch/bzip2:0=
	app-arch/zstd:0=
	>=dev-lang/ocaml-5:0=[ocamlopt?]
	sys-libs/libunwind:0=
	virtual/libelf:0="
BDEPEND="dev-ml/dune-configurator"
