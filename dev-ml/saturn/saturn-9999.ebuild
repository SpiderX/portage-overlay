# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="Parallelism-Safe Data Structures for Multicore OCaml"
HOMEPAGE="https://github.com/ocaml-multicore/saturn"
EGIT_REPO_URI="https://github.com/ocaml-multicore/${PN}.git"

LICENSE="ISC"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/backoff:0=[ocamlopt?]
	dev-ml/multicore-magic:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest
		dev-ml/domain_shims
		dev-ml/dscheck
		dev-ml/mdx
		dev-ml/multicoretests
		dev-ml/multicore-bench
		dev-ml/qcheck
		dev-ml/yojson )"
