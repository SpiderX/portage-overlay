# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit opam

DESCRIPTION="Camomile is a comprehensive Unicode library for ocaml"
HOMEPAGE="https://github.com/yoriyuki/Camomile"
SRC_URI="https://github.com/yoriyuki/${PN^}/archive/${PV}.tar.gz -> ${P^}.tar.gz"

LICENSE="LGPL-2+"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt"

RDEPEND="dev-lang/ocaml:=[ocamlopt?]"
DEPEND="${RDEPEND}"
BDEPEND=">=dev-ml/dune-1.11.1:="

S="${WORKDIR}/${P^}"
