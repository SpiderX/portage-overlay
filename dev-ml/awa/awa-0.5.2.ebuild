# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="awa awa-mirage"

inherit dune

MY_PN="${PN}-ssh"

DESCRIPTION="Purely functional SSH library in OCaml"
HOMEPAGE="https://github.com/mirage/awa-ssh"
SRC_URI="https://github.com/mirage/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/cmdliner:0=[ocamlopt?]
	dev-ml/cstruct:0=[ocamlopt?]
	dev-ml/duration:0=[ocamlopt?]
	dev-ml/eqaf:0=[ocamlopt?]
	dev-ml/fmt:0=[ocamlopt?]
	dev-ml/logs:0=[ocamlopt?]
	dev-ml/lwt:0=[ocamlopt?]
	dev-ml/mirage-crypto:0=[ocamlopt?]
	dev-ml/mirage-flow:0=[ocamlopt?]
	dev-ml/mirage-mtime:0=[ocamlopt?]
	dev-ml/mirage-sleep:0=[ocamlopt?]
	dev-ml/mtime:0=
	dev-ml/ocaml-base64:0=[ocamlopt?]
	dev-ml/x509:0=[ocamlopt?]
	dev-ml/zarith:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest )"
