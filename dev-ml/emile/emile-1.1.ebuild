# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Parser of email address in OCaml"
HOMEPAGE="https://github.com/mirage/emile"
SRC_URI="https://github.com/mirage/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/angstrom[ocamlopt?]
	dev-ml/cmdliner:0=[ocamlopt?]
	dev-ml/ocaml-base64:0=[ocamlopt?]
	dev-ml/ipaddr:0=[ocamlopt?]
	dev-ml/pecu:0=[ocamlopt?]
	dev-ml/uutf:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest )"
