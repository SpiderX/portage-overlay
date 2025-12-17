# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="Bindings to jemalloc mallctl api"
HOMEPAGE="https://github.com/ahrefs/ocaml-jemalloc"
EGIT_REPO_URI="https://github.com/ahrefs/ocaml-jemalloc.git"

LICENSE="MIT"
SLOT="0/${PV}"
IUSE="+ocamlopt"

DEPEND="dev-libs/jemalloc:0="
