# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="testo testo-diff testo-lwt testo-util"

inherit dune

DESCRIPTION="Test framework for OCaml"
HOMEPAGE="https://github.com/mjambon/testo"
SRC_URI="https://github.com/mjambon/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/cmdliner:0=[ocamlopt?]
	dev-ml/fpath:0=
	dev-ml/lwt:0=[ocamlopt?]
	dev-ml/ppx_deriving:0=[ocamlopt?]
	dev-ml/re:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest )"
