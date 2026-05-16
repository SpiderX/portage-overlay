# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="dns dns-certify dns-mirage dns-resolver dns-server
	dns-tsig dnssec"

inherit dune

MY_PN="ocaml-${PN}"

DESCRIPTION="OCaml implementation of the DNS protocol"
HOMEPAGE="https://github.com/mirage/ocaml-dns"
SRC_URI="https://github.com/mirage/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="BSD-2"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/ca-certs-nss:0=[ocamlopt?]
	dev-ml/cstruct:0=[ocamlopt?]
	dev-ml/digestif:0=[ocamlopt?]
	dev-ml/domain-name:0=[ocamlopt?]
	dev-ml/duration:0=[ocamlopt?]
	dev-ml/eqaf:0=[ocamlopt?]
	dev-ml/fmt:0=[ocamlopt?]
	dev-ml/gmap:0=[ocamlopt?]
	dev-ml/ipaddr:0=[ocamlopt?]
	dev-ml/logs:0=[ocamlopt?]
	dev-ml/lru:0=[ocamlopt?]
	dev-ml/lwt:0=[ocamlopt?]
	dev-ml/metrics:0=[ocamlopt?]
	dev-ml/mirage-crypto:0=[ocamlopt?]
	dev-ml/mirage-mtime:0=[ocamlopt?]
	dev-ml/mirage-ptime:0=[ocamlopt?]
	dev-ml/mirage-sleep:0=[ocamlopt?]
	dev-ml/ocaml-base64:0=[ocamlopt?]
	dev-ml/ohex:0=[ocamlopt?]
	dev-ml/ptime:0=[ocamlopt?]
	dev-ml/randomconv:0=[ocamlopt?]
	dev-ml/tcpip:0=[ocamlopt?]
	dev-ml/tls:0=[ocamlopt?]
	dev-ml/x509:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest )"

src_compile() {
	dune-compile ${DUNE_PKG_NAME}
}

src_test() {
	dune-test ${DUNE_PKG_NAME}
}
