# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="Fast implementation of queue in OCaml"
HOMEPAGE="https://github.com/mirage/ke"
EGIT_REPO_URI="https://github.com/mirage/${PN}.git"

LICENSE="MIT"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/fmt:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest
		dev-ml/bechamel
		dev-ml/bigstringaf
		dev-ml/cmdliner
		dev-ml/core_bench
		dev-ml/crowbar
		dev-ml/jsonm
		dev-ml/lwt
		dev-ml/ocplib-json-typed
		dev-ml/psq
		dev-ml/rresult )"
