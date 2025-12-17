# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="Convert random byte vectors to numbers"
HOMEPAGE="https://github.com/hannesm/randomconv"
EGIT_REPO_URI="https://github.com/hannesm/${PN}.git"

LICENSE="ISC"
SLOT="0/${PV}"
IUSE="+ocamlopt"
