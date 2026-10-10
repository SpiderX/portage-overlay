# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Adler-32, CRC32 and CRC32-C implementation in C and OCaml"
HOMEPAGE="https://github.com/mirage/checkseum"
SRC_URI="https://github.com/mirage/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/optint:0=[ocamlopt?]"
BDEPEND="dev-ml/dune-configurator
	dev-ml/findlib
	test? ( dev-ml/alcotest
		dev-ml/astring
		dev-ml/bos
		dev-ml/fmt
		dev-ml/fpath
		dev-ml/rresult )"
