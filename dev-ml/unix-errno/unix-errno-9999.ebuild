# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="Unix errno types, maps, and support for OCaml"
HOMEPAGE="https://github.com/xapi-project/ocaml-unix-errno"
EGIT_REPO_URI="https://github.com/xapi-project/ocaml-unix-errno.git"

LICENSE="ISC"
SLOT="0/${PV}"
IUSE="+ocamlopt"

RDEPEND="dev-ml/ocaml-ctypes:0=[ocamlopt?]"
