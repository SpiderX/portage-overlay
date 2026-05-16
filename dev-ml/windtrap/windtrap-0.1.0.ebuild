# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="ppx_windtrap windtrap"

inherit dune

DESCRIPTION="One library for all your OCaml tests"
HOMEPAGE="https://github.com/invariant-hq/windtrap"
SRC_URI="https://github.com/invariant-hq/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND=">=dev-lang/ocaml-5:0=[ocamlopt?]
	dev-ml/ppxlib:0=[ocamlopt?]"

PATCHES=( "${FILESDIR}/${PN}"-0.1.0-ppxlib-0.35.patch )

src_prepare() {
	default

	# relax requirements
	sed -i '/lang dune/s|3.21|3.16|' dune-project \
		|| die "sed failed"
}
