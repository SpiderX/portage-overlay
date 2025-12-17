# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Hexdump in OCaml"
HOMEPAGE="https://github.com/dinosaure/hxd"
SRC_URI="https://github.com/dinosaure/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt"

RDEPEND="dev-ml/cmdliner:0=[ocamlopt?]"
BDEPEND="dev-ml/dune-configurator"
