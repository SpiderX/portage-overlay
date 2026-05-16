# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

COMMIT="060ebb528e88b27124b33b5cfaf8ed04b7da6e41"

DESCRIPTION="OCaml bindings to backward-cpp"
HOMEPAGE="https://github.com/semgrep/obackward"
SRC_URI="https://github.com/semgrep/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

RDEPEND="app-arch/bzip2:0=
	app-arch/zstd:0=
	>=dev-lang/ocaml-5:0=[ocamlopt?]
	sys-libs/libunwind:0=
	virtual/libelf:0="
BDEPEND="dev-ml/dune-configurator"
