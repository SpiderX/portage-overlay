# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="git git-mirage git-paf git-unix"

inherit dune git-r3

DESCRIPTION="Pure OCaml Git format and protocol"
HOMEPAGE="https://github.com/mirage/ocaml-git"
EGIT_REPO_URI="https://github.com/mirage/ocaml-git.git"

LICENSE="ISC"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/angstrom:=[ocamlopt?]
	dev-ml/astring:=
	dev-ml/awa:0=[ocamlopt?]
	dev-ml/bigstringaf:=[ocamlopt?]
	dev-ml/base:0=[ocamlopt?]
	dev-ml/bos:=
	dev-ml/ca-certs-nss:0=[ocamlopt?]
	~dev-ml/carton-0.7.2:0=[ocamlopt?]
	dev-ml/checkseum:0=[ocamlopt?]
	dev-ml/cmdliner:0=[ocamlopt?]
	dev-ml/cstruct:0=[ocamlopt?]
	dev-ml/decompress:0=[ocamlopt?]
	dev-ml/digestif:0=[ocamlopt?]
	dev-ml/domain-name:0=[ocamlopt?]
	dev-ml/encore:0=[ocamlopt?]
	dev-ml/emile:0=[ocamlopt?]
	dev-ml/fmt:0=[ocamlopt?]
	dev-ml/fpath:=
	~dev-ml/h1-1.0.0:0=[ocamlopt?]
	dev-ml/happy-eyeballs:0=[ocamlopt?]
	dev-ml/hxd:0=[ocamlopt?]
	dev-ml/ipaddr:0=[ocamlopt?]
	dev-ml/ke:0=[ocamlopt?]
	dev-ml/logs:0=[ocamlopt?]
	dev-ml/lwt:0=[ocamlopt?]
	dev-ml/mimic:0=[ocamlopt?]
	dev-ml/mirage-crypto:0=[ocamlopt?]
	dev-ml/mirage-flow:0=[ocamlopt?]
	dev-ml/mirage-ptime:0=[ocamlopt?]
	dev-ml/mirage-sleep:0=[ocamlopt?]
	dev-ml/mtime:=
	dev-ml/ocaml-base64:0=[ocamlopt?]
	dev-ml/ocamlgraph:0=[ocamlopt?]
	dev-ml/optint:0=[ocamlopt?]
	dev-ml/paf:0=[ocamlopt?]
	dev-ml/psq:0=[ocamlopt?]
	dev-ml/ptime:0=[ocamlopt?]
	dev-ml/rresult:0=
	dev-ml/tcpip:0=[ocamlopt?]
	dev-ml/tls:0=[ocamlopt?]
	dev-ml/uri:0=[ocamlopt?]
	dev-ml/x509:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest
		dev-ml/alcotest-lwt
		dev-ml/crowbar )"

src_compile() {
	dune-compile ${DUNE_PKG_NAME}
}
