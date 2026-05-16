# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="Code coverage for OCaml and ReScript"
HOMEPAGE="https://github.com/aantron/bisect_ppx"
EGIT_REPO_URI="https://github.com/aantron/${PN}.git"

LICENSE="MIT"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/cmdliner:0=[ocamlopt?]
	<dev-ml/ppxlib-0.36:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/ocamlformat )"
