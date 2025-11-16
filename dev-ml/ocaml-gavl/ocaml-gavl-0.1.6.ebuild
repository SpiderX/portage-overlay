# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo findlib

COMMIT="a6ab72d2ef64978b64e90b93fca386c4ad5bb874"

DESCRIPTION="OCaml bindings to Gavl video manipulation library"
HOMEPAGE="https://github.com/savonet/ocaml-gavl"
SRC_URI="https://github.com/savonet/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="GPL-2"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="media-libs/gavl"

DOCS=( CHANGES README )

src_prepare() {
	default

	edo ./bootstrap
}

src_configure() {
	econf "$(use_enable ocamlopt nativecode)" --host=''
}

src_install() {
	einstalldocs
	findlib_src_install
}
