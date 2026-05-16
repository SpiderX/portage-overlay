# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Indentation tool for OCaml"
HOMEPAGE="https://github.com/OCamlPro/ocp-indent"
SRC_URI="https://github.com/OCamlPro/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt"

RDEPEND="dev-ml/cmdliner:0=[ocamlopt?]"
BDEPEND="dev-ml/findlib"
