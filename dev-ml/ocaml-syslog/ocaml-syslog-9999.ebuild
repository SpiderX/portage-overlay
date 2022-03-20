# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="syslog"
EGIT_REPO_URI="https://github.com/geneanet/${PN}.git"

inherit dune git-r3

DESCRIPTION="OCaml syslog client functions"
HOMEPAGE="https://github.com/geneanet/ocaml-syslog"
SRC_URI=""

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
KEYWORDS=""
IUSE="+ocamlopt"
