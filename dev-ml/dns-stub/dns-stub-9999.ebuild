# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="dns-stub"

inherit dune git-r3

DESCRIPTION="OCaml implementation of the DNS protocol"
HOMEPAGE="https://github.com/mirage/ocaml-dns"
EGIT_REPO_URI="https://github.com/mirage/ocaml-dns.git"

LICENSE="BSD-2"
SLOT="0/${PV}"
IUSE="+ocamlopt"

RDEPEND="dev-ml/cstruct:0=[ocamlopt?]
	dev-ml/dns:0=[ocamlopt?]
	dev-ml/dns-client:0=[ocamlopt?]
	dev-ml/duration:0=[ocamlopt?]
	dev-ml/lwt:0=[ocamlopt?]
	dev-ml/metrics:0=[ocamlopt?]
	dev-ml/mirage-crypto:0=[ocamlopt?]
	dev-ml/mirage-ptime:0=[ocamlopt?]
	dev-ml/randomconv:0=[ocamlopt?]
	dev-ml/tcpip:0=[ocamlopt?]
	dev-ml/tls:0=[ocamlopt?]"

src_compile() {
	dune-compile ${DUNE_PKG_NAME}
}

src_test() {
	dune-test ${DUNE_PKG_NAME}
}
