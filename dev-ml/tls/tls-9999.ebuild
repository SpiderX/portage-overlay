# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# tls-async needs cstruct-async
DUNE_PKG_NAME="tls tls-eio tls-lwt tls-miou-unix tls-mirage"

inherit dune git-r3

DESCRIPTION="Transport Layer Security purely in OCaml"
HOMEPAGE="https://github.com/mirleft/ocaml-tls"
EGIT_REPO_URI="https://github.com/mirleft/ocaml-tls.git"

LICENSE="BSD-2"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="test" # fails

RDEPEND=">=dev-lang/ocaml-5.0.0:0=[ocamlopt?]
	dev-ml/cmdliner:0=[ocamlopt?]
	dev-ml/digestif:0=[ocamlopt?]
	dev-ml/domain-name:0=[ocamlopt?]
	dev-ml/eio:0=[ocamlopt?]
	dev-ml/fmt:0=[ocamlopt?]
	dev-ml/ipaddr:0=[ocamlopt?]
	dev-ml/kdf:0=[ocamlopt?]
	dev-ml/logs:0=[ocamlopt?]
	dev-ml/lwt:0=[ocamlopt?]
	dev-ml/miou:0=[ocamlopt?]
	dev-ml/mirage-crypto:0=[ocamlopt?]
	dev-ml/mirage-flow:0=[ocamlopt?]
	dev-ml/mirage-kv:0=[ocamlopt?]
	dev-ml/mirage-ptime:0=[ocamlopt?]
	dev-ml/ohex:0=[ocamlopt?]
	dev-ml/ptime:0=[ocamlopt?]
	dev-ml/x509:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest
		dev-ml/crowbar
		dev-ml/hxd
		dev-ml/mdx
		dev-ml/ounit2
		dev-ml/randomconv
		dev-ml/rresult )"

src_compile() {
	dune-compile ${DUNE_PKG_NAME}
}
