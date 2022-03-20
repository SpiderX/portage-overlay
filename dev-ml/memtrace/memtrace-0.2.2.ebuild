# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Streaming client for OCaml's Memprof"
HOMEPAGE="https://github.com/janestreet/memtrace"
SRC_URI="https://github.com/janestreet/${PN}/archive/v${PV}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt"

src_prepare() {
	default

	rm LICENSE.md || die "rm failed"
}
