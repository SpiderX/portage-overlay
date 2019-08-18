# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools findlib

DESCRIPTION="OCaml bindings to libmagic"
HOMEPAGE="https://sourceforge.net/projects/ocaml-magic"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt"

RDEPEND="dev-lang/ocaml:=[ocamlopt?]"
DEPEND="${RDEPEND}
	dev-ml/findlib[ocamlopt?]"

DOCS=( ChangeLog )

src_prepare() {
	default
	eautoreconf
}

src_install() {
	einstalldocs
	findlib_src_install
}
