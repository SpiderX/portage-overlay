# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="A Markdown frontend in pure OCaml"
HOMEPAGE="https://github.com/ocaml-community/omd"
SRC_URI="https://github.com/ocaml-community/omd/releases/download/${PV/_/.}/${P/_/.}.tbz"
S="${WORKDIR}/${P/_/.}"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/uucp:0=
	dev-ml/uunf:0=
	dev-ml/uutf:0=[ocamlopt?]"
BDEPEND="dev-ml/dune-build-info
	test? ( dev-ml/ppx_expect )"
