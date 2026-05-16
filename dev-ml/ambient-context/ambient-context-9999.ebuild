# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="ambient-context ambient-context-eio ambient-context-lwt"

inherit dune git-r3

DESCRIPTION="Abstraction over thread- and continuation-local storage mechanisms"
HOMEPAGE="https://github.com/ocaml-tracing/ambient-context"
EGIT_REPO_URI="https://github.com/ocaml-tracing/${PN}.git"

LICENSE="MIT"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND=">=dev-lang/ocaml-5:0=[ocamlopt?]
	dev-ml/eio:0=[ocamlopt?]
	dev-ml/hmap:=
	dev-ml/lwt:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest
		dev-ml/alcotest-lwt
		dev-ml/bisect_ppx )"
