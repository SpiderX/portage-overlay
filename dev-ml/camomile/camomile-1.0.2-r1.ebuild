# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="A Unicode library for OCaml"
HOMEPAGE="https://github.com/yoriyuki/Camomile"
SRC_URI="https://github.com/yoriyuki/${PN}/archive/${PV}/${P^}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~ppc64 ~x86"
IUSE="+ocamlopt"

S="${WORKDIR}/${P^}"

src_prepare() {
	default

	rm LICENSE.md || die "rm failed"

	# Specify version
	sed -i "/^(name camomile)/i(version ${PV})" dune-project \
		|| die "sed failed"
}
