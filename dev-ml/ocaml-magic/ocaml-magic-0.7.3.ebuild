# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools findlib

DESCRIPTION="OCaml bindings to libmagic"
HOMEPAGE="https://github.com/savonet/ocaml-magic https://sourceforge.net/projects/ocaml-magic/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-lang/ocaml:="
DEPEND="${RDEPEND}
	dev-ml/findlib"

DOCS=( ChangeLog )

src_prepare() {
	default
	eautoreconf
}

src_install() {
	einstalldocs
	findlib_src_install
}
