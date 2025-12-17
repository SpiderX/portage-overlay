# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="X509 handling in OCaml"
HOMEPAGE="https://github.com/mirleft/ocaml-x509"
SRC_URI="https://github.com/mirleft/ocaml-${PN}/releases/download/v${PV}/${P}.tbz"

LICENSE="BSD-2"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/asn1-combinators:0=[ocamlopt?]
	dev-ml/domain-name:0=[ocamlopt?]
	dev-ml/fmt:0=[ocamlopt?]
	dev-ml/gmap:0=[ocamlopt?]
	dev-ml/ipaddr:0=[ocamlopt?]
	dev-ml/kdf:0=[ocamlopt?]
	dev-ml/logs:0=[ocamlopt?]
	dev-ml/ocaml-base64:0=[ocamlopt?]
	dev-ml/ohex:0=[ocamlopt?]
	dev-ml/mirage-crypto:0=[ocamlopt?]
	dev-ml/ptime:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest )"
