# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Assemble and manage fully vendored Dune repositories"
HOMEPAGE="https://github.com/tarides/opam-monorepo"
SRC_URI="https://github.com/tarides/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt"
RESTRICT="test" # needs git layout

BDEPEND="virtual/pkgconfig"
