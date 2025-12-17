# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="Declarative terminal graphics for OCaml"
HOMEPAGE="https://github.com/pqwy/notty"
EGIT_REPO_URI="https://github.com/pqwy/${PN}.git"

LICENSE="ISC"
SLOT="0/${PV}"
IUSE="+ocamlopt"

RDEPEND="dev-ml/lwt:0=[ocamlopt?]
	dev-ml/uutf:0=[ocamlopt?]"
BDEPEND="dev-ml/cppo"

PATCHES=( "${FILESDIR}/${PN}"-0.2.3-ocaml5.patch )
