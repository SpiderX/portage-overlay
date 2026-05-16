# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="awa awa-mirage"

inherit dune git-r3

DESCRIPTION="Purely functional SSH library in OCaml"
HOMEPAGE="https://github.com/mirage/awa-ssh"
EGIT_REPO_URI="https://github.com/mirage/awa-ssh.git"

LICENSE="ISC"
SLOT="0/${PV}"
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
