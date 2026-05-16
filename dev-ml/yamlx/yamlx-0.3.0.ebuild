# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Pure-OCaml YAML 1.2 & 1.1 Library"
HOMEPAGE="https://github.com/mjambon/yamlx"
SRC_URI="https://github.com/mjambon/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="AGPL-3"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/ppx_deriving:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/testo )"
