# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="ppx_windtrap windtrap"

inherit dune git-r3

DESCRIPTION="One library for all your OCaml tests"
HOMEPAGE="https://github.com/invariant-hq/windtrap"
EGIT_REPO_URI="https://github.com/invariant-hq/${PN}.git"

LICENSE="ISC"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND=">=dev-lang/ocaml-5:0=[ocamlopt?]
	dev-ml/ppxlib:0=[ocamlopt?]"

src_prepare() {
	default

	sed -i '/lang/s|3.21|3.20|' {examples/x-blueprint/,}dune-project \
		|| die "sed failed for dune-project"
	sed -i '/"dune"/s|3.21|3.20|' {ppx_,}windtrap.opam || die "sed failed for opam"
}
