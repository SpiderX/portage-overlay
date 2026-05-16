# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune edo

COMMIT="772e36fb4899651856d38478bc796da2cd85968d"
VISITORS_TAG="20250212"
VISITORS_COMMIT="aec49fa58c86e5d67d54d0e8c85cc9ad87dc32a1"
MY_PN="semgrep-ocaml-visitors"

DESCRIPTION="A implementation of OCaml's visitors"
HOMEPAGE="https://github.com/semgrep/semgrep-ocaml-visitors"
SRC_URI="https://github.com/semgrep/${MY_PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz
	https://gitlab.inria.fr/fpottier/visitors/-/archive/${VISITORS_TAG}/${P}.tar.bz2"
S="${WORKDIR}/${MY_PN}-${COMMIT}"

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"
RESTRICT="test" # fails

RDEPEND="<dev-ml/ppxlib-0.37:0=[ocamlopt?]
	dev-ml/ppx_deriving_yojson:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest
		dev-ml/qcheck )"

src_prepare() {
	default

	edo rmdir vendor/visitors
	edo ln -s ../../visitors-"${VISITORS_TAG}-${VISITORS_COMMIT}" vendor/visitors
}
