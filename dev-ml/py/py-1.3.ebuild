# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..15} )

inherit dune python-any-r1

MY_PN="ocaml-${PN}"

DESCRIPTION="Python bindings for OCaml"
HOMEPAGE="https://github.com/zshipko/ocaml-py"
SRC_URI="https://github.com/zshipko/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt"

DEPEND="${PYTHON_DEPS}"
RDEPEND="dev-ml/ocaml-ctypes:0=[ocamlopt?]"

pkg_setup() {
	python-any-r1_pkg_setup
}
