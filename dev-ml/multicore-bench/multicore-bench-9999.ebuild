# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="Framework for writing multicore benchmark executables"
HOMEPAGE="https://github.com/ocaml-multicore/multicore-bench"
EGIT_REPO_URI="https://github.com/ocaml-multicore/${PN}.git"

LICENSE="ISC"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/backoff:0=[ocamlopt?]
	dev-ml/domain-local-await:0=[ocamlopt?]
	dev-ml/domain_shims:0=[ocamlopt?]
	dev-ml/mtime:0=
	dev-ml/multicore-magic:0=[ocamlopt?]
	dev-ml/yojson:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/mdx )"
