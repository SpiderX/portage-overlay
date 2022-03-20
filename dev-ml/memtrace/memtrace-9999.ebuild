# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/janestreet/${PN}.git"

inherit dune git-r3

DESCRIPTION="Streaming client for OCaml's Memprof"
HOMEPAGE="https://github.com/janestreet/memtrace"
SRC_URI=""

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS=""
IUSE="+ocamlopt"

src_prepare() {
	default

	rm LICENSE.md || die "rm failed"
}
