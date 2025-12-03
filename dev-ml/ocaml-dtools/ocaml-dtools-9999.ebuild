# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="dtools"

inherit dune git-r3

DESCRIPTION="OCaml daemon tools library"
HOMEPAGE="https://github.com/savonet/ocaml-dtools"
EGIT_REPO_URI="https://github.com/savonet/${PN}.git"

LICENSE="GPL-2"
SLOT="0/${PV}"
IUSE="+ocamlopt syslog"

RDEPEND="syslog? ( dev-ml/ocaml-syslog:= )"
