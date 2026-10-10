# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

MY_PN="ocaml-${PN}"

DESCRIPTION="Read metadata from various file formats"
HOMEPAGE="https://github.com/savonet/ocaml-metadata"
SRC_URI="https://github.com/savonet/${MY_PN}/archive/v${PV}/${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="GPL-3"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt"
