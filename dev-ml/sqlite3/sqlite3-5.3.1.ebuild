# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="SQLite3 bindings for OCaml"
HOMEPAGE="https://github.com/mmottl/sqlite3-ocaml"
SRC_URI="https://github.com/mmottl/${PN}-ocaml/releases/download/${PV}/${P}.tbz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

DEPEND="dev-db/sqlite:3"
BDEPEND="dev-ml/dune-configurator
	test? ( dev-ml/ppx_inline_test )"
