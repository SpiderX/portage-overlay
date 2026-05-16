# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="Efficient thread local storage for OCaml"
HOMEPAGE="https://github.com/c-cube/thread-local-storage"
EGIT_REPO_URI="https://github.com/c-cube/${PN}.git"

LICENSE="MIT"
SLOT="0/${PV}"
IUSE="+ocamlopt"
