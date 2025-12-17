# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="containers containers-data"

inherit dune

DESCRIPTION="Standard library extension and interfaces to various libraries"
HOMEPAGE="https://github.com/c-cube/ocaml-containers"
SRC_URI="https://github.com/c-cube/ocaml-${PN}/releases/download/v${PV}/${P}.tbz"

LICENSE="BSD-2"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/either:0=[ocamlopt?]
	dev-ml/qcheck:0=[ocamlopt?]"
BDEPEND="dev-ml/dune-configurator
	test? ( dev-ml/csexp
		dev-ml/gen
		dev-ml/iter
		dev-ml/mdx
		dev-ml/yojson
		dev-ml/uutf )"

PATCHES=( "${FILESDIR}/${PN}"-3.16-test-cbor.patch )
