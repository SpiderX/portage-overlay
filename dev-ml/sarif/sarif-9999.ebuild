# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="Static Analysis Results Interchange Format (SARIF) For OCaml"
HOMEPAGE="https://github.com/gborough/sarif"
EGIT_REPO_URI="https://github.com/gborough/${PN}.git"

LICENSE="MIT"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/atd:0=[ocamlopt?]
	dev-ml/ppx_deriving:0=[ocamlopt?]
	dev-ml/re:0=[ocamlopt?]
	dev-ml/timedesc:0=[ocamlopt?]
	dev-ml/uri:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest
		dev-ml/ppx_expect )"

src_prepare() {
	default

	# remove non-existed dependency
	sed -i '/ppx_expect.common/d' test/dune || die "sed failed"
}
