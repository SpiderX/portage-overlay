# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Simple hash algorithms in OCaml"
HOMEPAGE="https://github.com/mirage/digestif"
SRC_URI="https://github.com/mirage/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/eqaf:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest
		dev-ml/astring
		dev-ml/bos
		dev-ml/crowbar
		dev-ml/findlib
		dev-ml/fmt
		dev-ml/fpath
		dev-ml/rresult )"
