# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Camomile is a comprehensive Unicode library for ocaml"
HOMEPAGE="https://github.com/yoriyuki/Camomile"
SRC_URI="https://github.com/yoriyuki/Camomile/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2+"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
DEPEND="
	>=dev-lang/ocaml-4.02.3:=
	>=dev-ml/dune-1.11.0
"
DOCS=( CHANGES.md README.md )
S="${WORKDIR}/Camomile-${PV}"

src_prepare() {
	default
	dune upgrade || die
}

src_compile() {
	dune build --profile=release @install || die
}

src_install() {
	dune install --destdir="${D}" || die
	einstalldocs
	rm -r "${D}/usr/doc" || die
}
