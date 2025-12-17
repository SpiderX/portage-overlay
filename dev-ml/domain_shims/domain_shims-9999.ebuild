# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="Domain module for OCaml 4"
HOMEPAGE="https://gitlab.com/gasche/domain-shims"
EGIT_REPO_URI="https://gitlab.com/gasche/domain-shims.git"

LICENSE="ISC"
SLOT="0/${PV}"
IUSE="+ocamlopt"
