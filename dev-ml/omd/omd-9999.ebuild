# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="A Markdown frontend in pure OCaml"
HOMEPAGE="https://github.com/ocaml-community/omd"
EGIT_REPO_URI="https://github.com/ocaml-community/${PN}.git"

LICENSE="ISC"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/uucp:0=
	dev-ml/uunf:0=
	dev-ml/uutf:0=[ocamlopt?]"
BDEPEND="dev-ml/dune-build-info
	test? ( dev-ml/ppx_expect )"
