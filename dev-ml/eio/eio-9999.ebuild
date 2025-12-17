# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="eio eio_linux eio_main eio_posix"

inherit dune edo git-r3

DESCRIPTION="Effects-Based Parallel IO for OCaml"
HOMEPAGE="https://github.com/ocaml-multicore/eio"
EGIT_REPO_URI="https://github.com/ocaml-multicore/${PN}.git"

LICENSE="ISC"
SLOT="0/${PV}"
IUSE="ipv6 +ocamlopt test"
RESTRICT="test" # fails

RDEPEND=">=dev-lang/ocaml-5.2.0:0=
	dev-ml/bigstringaf[ocamlopt?]
	dev-ml/crowbar:0=[ocamlopt?]
	dev-ml/cstruct:0=[ocamlopt?]
	dev-ml/domain-local-await:0=[ocamlopt?]
	>=dev-ml/dune-3.19:0=
	dev-ml/fmt:0=[ocamlopt?]
	dev-ml/hmap
	dev-ml/iomux:0=[ocamlopt?]
	dev-ml/logs:0=[ocamlopt?]
	dev-ml/lwt-dllist:0=[ocamlopt?]
	dev-ml/mdx:0=[ocamlopt?]
	dev-ml/mtime:0=
	dev-ml/optint:0=[ocamlopt?]
	dev-ml/psq:0=[ocamlopt?]
	dev-ml/uring:0=[ocamlopt?]
	dev-ml/yojson:0=[ocamlopt?]"
BDEPEND="dev-ml/dune-configurator
	test? ( dev-ml/alcotest
		dev-ml/cmdliner
		dev-ml/dscheck
		dev-ml/kcas )"

src_prepare() {
	default

	# remove tests fail in portage sandbox
	edo rm lib_eio_{linux/tests,posix/test}/spawn.md
	edo rm -rf {bench,stress}

	! use ipv6 && eapply "${FILESDIR}/${PN}"-0.11-test-ipv6.patch
}
