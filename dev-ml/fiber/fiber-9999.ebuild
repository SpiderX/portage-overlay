# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="fiber fiber-lwt"

inherit dune git-r3

DESCRIPTION="Dune's monadic structured concurrency library"
HOMEPAGE="https://github.com/ocaml-dune/fiber"
EGIT_REPO_URI="https://github.com/ocaml-dune/${PN}.git"

LICENSE="MIT"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/dune-private-libs:0=[ocamlopt?]
	dev-ml/lwt:0=[ocamlopt?]"
BDEPEND="test? ( >=dev-ml/ppx_expect-0.17 )"

src_prepare() {
	default

	# remove non-existed dependency
	sed -i '/ppx_expect.common/d' fiber/test/dune || die "sed failed"
}

src_compile() {
	dune-compile ${DUNE_PKG_NAME}
}
