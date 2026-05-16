# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="h2 h2-async h2-eio h2-lwt h2-lwt-unix h2-mirage hpack"

inherit dune edo

COMMIT="5c67db0d4d68e1fb7d3a241d6e01fc04d981f465"
MY_PN="ocaml-${PN}"

DESCRIPTION="An HTTP/2 implementation written in pure OCaml"
HOMEPAGE="https://github.com/anmonteiro/ocaml-h2"
SRC_URI="https://github.com/anmonteiro/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/http2jp/http2-frame-test-case/archive/${COMMIT}.tar.gz -> ${P}-tests.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/angstrom:0=[ocamlopt?]
	dev-ml/bigstringaf:0=[ocamlopt?]
	dev-ml/cstruct:0=[ocamlopt?]
	dev-ml/faraday:0=[ocamlopt?]
	dev-ml/gluten:0=[ocamlopt?]
	dev-ml/httpun:0=[ocamlopt?]
	dev-ml/lwt:0=[ocamlopt?]
	dev-ml/mirage-flow:0=[ocamlopt?]
	dev-ml/ocaml-base64:0=[ocamlopt?]
	dev-ml/psq:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest
		dev-ml/hex
		dev-ml/yojson )"

src_prepare() {
	default

	edo rmdir lib_test/http2-frame-test-case
	edo ln -s ../../http2-frame-test-case-"${COMMIT}" lib_test/http2-frame-test-case
}
