# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="fiber fiber-lwt"

inherit dune

DESCRIPTION="Dune's monadic structured concurrency library"
HOMEPAGE="https://github.com/ocaml-dune/fiber"
SRC_URI="https://github.com/ocaml-dune/fiber/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/dune-private-libs:0=[ocamlopt?]
	dev-ml/lwt:0=[ocamlopt?]"
BDEPEND="test? ( >=dev-ml/ppx_expect-0.17 )"

PATCHES=( "${FILESDIR}/${PN}"-3.7.0-tests.patch )

src_prepare() {
	default

	# remove non-existed dependency
	sed -i '/ppx_expect.common/d' fiber/test/dune || die "sed failed"
}

src_compile() {
	dune-compile ${DUNE_PKG_NAME}
}
