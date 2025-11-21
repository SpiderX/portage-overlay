# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune edo git-r3

DESCRIPTION="Streaming client for OCaml's Memprof"
HOMEPAGE="https://github.com/janestreet/memtrace"
EGIT_REPO_URI="https://github.com/janestreet/${PN}.git"

LICENSE="MIT"
SLOT="0/${PV}"
IUSE="+ocamlopt"

src_prepare() {
	default

	edo rm LICENSE.md
}
