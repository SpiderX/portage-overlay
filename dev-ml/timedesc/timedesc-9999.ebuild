# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="timedesc timedesc-json timedesc-tzdb timedesc-sexp timedesc-tzlocal timedesc-tzlocal-js"

inherit dune git-r3

DESCRIPTION="OCaml date time handling and reasoning suite"
HOMEPAGE="https://github.com/daypack-dev/timere"
EGIT_REPO_URI="https://github.com/daypack-dev/timere.git"

LICENSE="MIT"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/angstrom:0=[ocamlopt?]
	dev-ml/js_of_ocaml:0=[ocamlopt?]
	dev-ml/ptime:0=[ocamlopt?]
	dev-ml/result:0=[ocamlopt?]
	dev-ml/seq:=[ocamlopt?]
	dev-ml/sexplib:0=[ocamlopt?]
	dev-ml/yojson:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest
		dev-ml/crowbar
		dev-ml/qcheck )"

src_compile() {
	dune-compile ${DUNE_PKG_NAME}
}
