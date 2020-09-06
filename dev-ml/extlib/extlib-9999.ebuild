# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/ygrek/ocaml-extlib.git"

inherit findlib git-r3

DESCRIPTION="Standard library extensions for O'Caml"
HOMEPAGE="https://github.com/ygrek/ocaml-extlib"
SRC_URI=""

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
KEYWORDS=""
IUSE="doc +ocamlopt"
RESTRICT="test" # fails

RDEPEND="dev-lang/ocaml:=[ocamlopt?]"
DEPEND="${RDEPEND}
	dev-ml/cppo:0="

PATCHES=( "${FILESDIR}"/"${PN}"-1.7.7-no-line-directive.patch ) #704146

DOCS=( CHANGES README.md )

src_compile() {
	cd src || die "cd failed"
	emake all
	use ocamlopt && emake opt cmxs
	use doc && emake doc
}

src_test() {
	emake test
}

src_install() {
	findlib_src_install
	einstalldocs
	use doc && dodoc -r src/doc/
}
