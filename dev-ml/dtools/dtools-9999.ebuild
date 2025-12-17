# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="OCaml daemon tools library"
HOMEPAGE="https://github.com/savonet/ocaml-dtools"
EGIT_REPO_URI="https://github.com/savonet/ocaml-dtools.git"

LICENSE="GPL-2"
SLOT="0/${PV}"
IUSE="+ocamlopt"

RDEPEND="dev-ml/saturn:0=[ocamlopt?]
	dev-ml/syslog:0=[ocamlopt?]"

src_prepare() {
	default

	sed -i 's/saturn_lockfree/saturn/' dune-project src/dune \
		|| die "sed failed for dune-project"
	sed -i 's/Saturn_lockfree/Saturn/' src/dtools_impl.ml \
		|| die "sed failed for dtools_impl.ml"
}
