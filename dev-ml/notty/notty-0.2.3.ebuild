# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Declarative terminal graphics for OCaml"
HOMEPAGE="https://github.com/pqwy/notty"
SRC_URI="https://github.com/pqwy/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt"

RDEPEND="dev-ml/lwt:0=[ocamlopt?]
	dev-ml/uutf:0=[ocamlopt?]"
BDEPEND="dev-ml/cppo"

PATCHES=( "${FILESDIR}/${PN}"-0.2.3-ocaml5.patch )
