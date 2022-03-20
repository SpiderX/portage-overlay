# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit opam

DESCRIPTION="Ocaml XML manipulation module"
HOMEPAGE="https://github.com/dbuenzli/xmlm"
SRC_URI="https://github.com/dbuenzli/${PN}/archive/v${PV}/${P}.tar.gz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="dev-ml/topkg:="

src_compile() {
	ocaml pkg/pkg.ml build \
		--tests "$(usex test 'true' 'false')" \
		|| die "compile failed"
}

src_test() {
	ocaml pkg/pkg.ml test || die "test failed"
}
