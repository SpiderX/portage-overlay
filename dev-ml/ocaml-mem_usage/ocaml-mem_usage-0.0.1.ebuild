# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="mem_usage"

inherit dune

DESCRIPTION="Cross-platform memory usage information"
HOMEPAGE="https://github.com/savonet/ocaml-mem_usage"
SRC_URI="https://github.com/savonet/${PN}/archive/v${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt"
