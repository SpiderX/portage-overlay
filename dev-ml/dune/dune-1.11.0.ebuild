# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A composable build system for OCaml"
HOMEPAGE="https://github.com/ocaml/dune"
SRC_URI="https://github.com/ocaml/dune/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=">=dev-lang/ocaml-4.02.3"
RDEPEND="
	${DEPEND}
	dev-ml/findlib
"
DOCS=( README.md CHANGES.md )

src_configure() {
	:
}

src_compile() {
	emake release || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	einstalldocs
	rm -r "${D}/usr/doc" || die
}
