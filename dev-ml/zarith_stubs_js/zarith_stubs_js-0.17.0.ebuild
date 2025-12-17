# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune edo

DESCRIPTION="Javascripts stubs for the Zarith library"
HOMEPAGE="https://github.com/janestreet/zarith_stubs_js"
SRC_URI="https://github.com/janestreet/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	test? ( https://raw.githubusercontent.com/ocaml/Zarith/refs/heads/master/z.ml )"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt test"
RESTRICT="test" # diff fails

BDEPEND="test? ( dev-ml/ppx_jane )"

PATCHES=( "${FILESDIR}/${PN}"-0.17.0-tests.patch )

src_test() {
	edo cp "${DISTDIR}"/z.ml "${S}"
	dune_src_test
}
