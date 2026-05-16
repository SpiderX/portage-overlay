# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Library to generate encoder/decoder which ensure isomorphism"
HOMEPAGE="https://github.com/mirage/encore"
SRC_URI="https://github.com/mirage/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/angstrom:=[ocamlopt?]
	dev-ml/bigstringaf:0=[ocamlopt?]
	dev-ml/fmt:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest )"
