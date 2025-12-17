# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Parallelism-Safe Data Structures for Multicore OCaml"
HOMEPAGE="https://github.com/ocaml-multicore/saturn"
SRC_URI="https://github.com/ocaml-multicore/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
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
