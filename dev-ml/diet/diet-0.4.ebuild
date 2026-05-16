# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

MY_PN="ocaml-${PN}"

DESCRIPTION="Ocaml Discrete Interval Encoding Trees"
HOMEPAGE="https://github.com/mirage/ocaml-diet"
SRC_URI="https://github.com/mirage/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/stdlib-shims:=[ocamlopt?]"
BDEPEND="test? ( dev-ml/ounit2 )"

src_prepare() {
	default

	# use ounit2
	sed -i '/libraries/s|oUnit|ounit2|' lib_test/dune \
		|| die "sed failed for dune"
	sed -i 's/ounit/ounit2/' diet.opam \
		|| die "sed failed for opam"
}
