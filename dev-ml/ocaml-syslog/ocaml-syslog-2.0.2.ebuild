# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="syslog"

inherit dune

DESCRIPTION="OCaml syslog client functions"
HOMEPAGE="https://github.com/geneanet/ocaml-syslog"
SRC_URI="https://github.com/geneanet/${PN}/archive/v${PV}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt"
