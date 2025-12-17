# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="Hexdump in OCaml"
HOMEPAGE="https://github.com/dinosaure/hxd"
EGIT_REPO_URI="https://github.com/dinosaure/${PN}.git"

LICENSE="MIT"
SLOT="0/${PV}"
IUSE="+ocamlopt"

RDEPEND="dev-ml/cmdliner:0=[ocamlopt?]"
BDEPEND="dev-ml/dune-configurator"
