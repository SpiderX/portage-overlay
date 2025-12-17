# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools findlib

MY_PN="ocaml-${PN}"

DESCRIPTION="OCaml bindings to libmagic"
HOMEPAGE="https://github.com/Chris00/ocaml-magic"
SRC_URI="https://github.com/Chris00/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="LGPL-2"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

DOCS=( ChangeLog )

src_prepare() {
	default
	eautoreconf
}

src_install() {
	einstalldocs
	findlib_src_install
}
