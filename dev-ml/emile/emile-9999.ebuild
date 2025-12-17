# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="Parser of email address in OCaml"
HOMEPAGE="https://github.com/mirage/emile"
EGIT_REPO_URI="https://github.com/mirage/${PN}.git"

LICENSE="MIT"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/angstrom[ocamlopt?]
	dev-ml/cmdliner:0=[ocamlopt?]
	dev-ml/ocaml-base64:0=[ocamlopt?]
	dev-ml/ipaddr:0=[ocamlopt?]
	dev-ml/pecu:0=[ocamlopt?]
	dev-ml/uutf:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest )"
