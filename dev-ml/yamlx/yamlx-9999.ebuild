# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="Pure-OCaml YAML 1.2 & 1.1 Library"
HOMEPAGE="https://github.com/mjambon/yamlx"
EGIT_REPO_URI="https://github.com/mjambon/${PN}.git"

LICENSE="AGPL-3"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/ppx_deriving:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/testo )"
