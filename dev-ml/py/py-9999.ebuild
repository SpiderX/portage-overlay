# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..15} )

inherit dune git-r3 python-any-r1

DESCRIPTION="Python bindings for OCaml"
HOMEPAGE="https://github.com/zshipko/ocaml-py"
EGIT_REPO_URI="https://github.com/zshipko/ocaml-py.git"

LICENSE="ISC"
SLOT="0/${PV}"
IUSE="+ocamlopt"

DEPEND="${PYTHON_DEPS}"
RDEPEND="dev-ml/ocaml-ctypes:0=[ocamlopt?]"

pkg_setup() {
	python-any-r1_pkg_setup
}
