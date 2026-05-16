# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# paf-cohttp https://github.com/dinosaure/paf-le-chien/issues/105
DUNE_PKG_NAME="paf"

inherit dune git-r3

DESCRIPTION="Port of HTTP/AF & H2 with Mirage and mimic"
HOMEPAGE="https://github.com/dinosaure/paf-le-chien"
EGIT_REPO_URI="https://github.com/dinosaure/paf-le-chien.git"

LICENSE="MIT"
SLOT="0/${PV}"
IUSE="ipv6 +ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/bigstringaf:0=[ocamlopt?]
	dev-ml/cstruct:0=[ocamlopt?]
	dev-ml/faraday:0=[ocamlopt?]
	dev-ml/h1:0=[ocamlopt?]
	dev-ml/h2:0=[ocamlopt?]
	dev-ml/ke:0=[ocamlopt?]
	dev-ml/mimic:0=[ocamlopt?]
	dev-ml/tcpip:0=[ocamlopt?]
	dev-ml/tls:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest
		dev-ml/alcotest-lwt
		dev-ml/base
		dev-ml/fmt
		dev-ml/logs
		dev-ml/lwt
		dev-ml/mirage-crypto
		dev-ml/ptime
		dev-ml/uri
		dev-ml/x509 )"

src_prepare() {
	default

	! use ipv6 && eapply "${FILESDIR}/${PN}"-0.8.0-test-ipv6.patch
}

src_compile() {
	dune-compile ${DUNE_PKG_NAME}
}

src_test() {
	dune-test ${DUNE_PKG_NAME}
}
