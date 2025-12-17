# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="OCaml syslog client functions"
HOMEPAGE="https://github.com/geneanet/ocaml-syslog"
EGIT_REPO_URI="https://github.com/geneanet/ocaml-syslog.git"

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
IUSE="+ocamlopt"
