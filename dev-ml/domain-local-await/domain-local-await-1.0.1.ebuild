# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Scheduler independent blocking"
HOMEPAGE="https://github.com/ocaml-multicore/domain-local-await"
SRC_URI="https://github.com/ocaml-multicore/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/thread-table[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest
		dev-ml/domain_shims
		dev-ml/mdx
		dev-ml/ocaml-version )"
