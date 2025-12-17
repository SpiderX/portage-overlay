# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="ipaddr ipaddr-cstruct ipaddr-sexp macaddr macaddr-cstruct macaddr-sexp"

inherit dune git-r3

DESCRIPTION="A library for manipulation of IP (and MAC) address representations"
HOMEPAGE="https://github.com/mirage/ocaml-ipaddr"
EGIT_REPO_URI="https://github.com/mirage/ocaml-ipaddr.git"

LICENSE="ISC"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/cstruct:0=[ocamlopt?]
	dev-ml/domain-name:0=[ocamlopt?]
	dev-ml/ppx_sexp_conv:0=[ocamlopt?]
	dev-ml/sexplib0:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/ounit2
		dev-ml/fmt )"
