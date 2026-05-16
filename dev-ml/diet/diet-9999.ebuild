# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

MY_PN="ocaml-${PN}"

DESCRIPTION="Ocaml Discrete Interval Encoding Trees"
HOMEPAGE="https://github.com/mirage/ocaml-diet"
EGIT_REPO_URI="https://github.com/mirage/ocaml-diet.git"

LICENSE="ISC"
SLOT="0/${PV}"
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
