# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit findlib

DESCRIPTION="Standard library extensions for O'Caml"
HOMEPAGE="https://github.com/ygrek/ocaml-extlib"
SRC_URI="https://github.com/ygrek/ocaml-extlib/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="doc +ocamlopt"
RESTRICT="test" # fails

RDEPEND="dev-lang/ocaml:=[ocamlopt?]"
DEPEND="${RDEPEND}
	dev-ml/cppo:0="

S="${WORKDIR}/ocaml-${P}"

PATCHES=( "${FILESDIR}"/"${P}"-no-line-directive.patch ) #704146

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
