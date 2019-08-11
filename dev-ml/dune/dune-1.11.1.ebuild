# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit multiprocessing

DESCRIPTION="A composable build system for OCaml"
HOMEPAGE="https://github.com/ocaml/dune"
SRC_URI="https://github.com/ocaml/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE="+ocamlopt test"

DEPEND="dev-lang/ocaml:=[ocamlopt?]"
RDEPEND="${DEPEND}
	!dev-ml/jbuilder:="

RESTRICT="test"

src_configure() {
	ocaml configure.ml --libdir "${EPREFIX}/usr/$(get_libdir)/ocaml" \
		|| die "ocaml for configure.ml failed"
}

src_compile() {
	ocaml bootstrap.ml || die "ocaml for bootstrap.ml failed"
	./boot.exe -j "$(makeopts_jobs)" || die "boot.exe failed"
}

src_install() {
	default
	mv "${D}"/usr/doc "${D}"/usr/share/doc/"${PF}" || die "moving doc failed"
	mv "${D}"/usr/man "${D}"/usr/share/man || die "moving man failed"
}
