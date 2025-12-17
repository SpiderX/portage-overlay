# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="Compatibility module for Either in OCaml 4.12"
HOMEPAGE="https://github.com/mirage/either"
EGIT_REPO_URI="https://github.com/mirage/${PN}.git"

LICENSE="MIT"
SLOT="0/${PV}"
IUSE="+ocamlopt"
