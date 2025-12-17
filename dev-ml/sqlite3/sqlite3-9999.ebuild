# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="SQLite3 bindings for OCaml"
HOMEPAGE="https://github.com/mmottl/sqlite3-ocaml"
EGIT_REPO_URI="https://github.com/mmottl/sqlite3-ocaml.git"

LICENSE="MIT"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

DEPEND="dev-db/sqlite:3"
BDEPEND="dev-ml/dune-configurator
	test? ( dev-ml/ppx_inline_test )"
