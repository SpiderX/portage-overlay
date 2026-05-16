# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Unix implementation of the Mirage_types.BLOCK interface"
HOMEPAGE="https://github.com/mirage/mirage-block-unix"
SRC_URI="https://github.com/mirage/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

DEPEND="sys-kernel/linux-headers"
RDEPEND="dev-ml/cstruct:0=[ocamlopt?]
	dev-ml/logs:0=[ocamlopt?]
	dev-ml/lwt:0=[ocamlopt?]
	dev-ml/mirage-block:0=[ocamlopt?]
	dev-ml/rresult:0=
	dev-ml/uri:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/diet
		dev-ml/fmt
		dev-ml/ounit2 )"
