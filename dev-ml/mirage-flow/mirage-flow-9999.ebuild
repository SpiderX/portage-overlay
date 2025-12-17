# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="mirage-flow mirage-flow-combinators mirage-flow-unix"

inherit dune git-r3

DESCRIPTION="Flow implementations and combinators for MirageOS"
HOMEPAGE="https://github.com/mirage/mirage-flow"
EGIT_REPO_URI="https://github.com/mirage/${PN}.git"

LICENSE="ISC"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/cstruct:0=[ocamlopt?]
	dev-ml/fmt:0=[ocamlopt?]
	dev-ml/logs:0=[ocamlopt?]
	dev-ml/lwt:0=[ocamlopt?]
	dev-ml/mirage-mtime:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest )"
