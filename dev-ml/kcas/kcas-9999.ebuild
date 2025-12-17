# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="kcas kcas_data"

inherit dune git-r3

DESCRIPTION="Software Transactional Memory for OCaml"
HOMEPAGE="https://github.com/ocaml-multicore/kcas"
EGIT_REPO_URI="https://github.com/ocaml-multicore/${PN}.git"

LICENSE="ISC"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/backoff:0=[ocamlopt?]
	dev-ml/domain-local-await:0=[ocamlopt?]
	dev-ml/domain-local-timeout:0=[ocamlopt?]
	dev-ml/multicore-bench:0=[ocamlopt?]
	dev-ml/multicore-magic:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest
		dev-ml/domain_shims
		dev-ml/mdx
		dev-ml/multicoretests
		dev-ml/qcheck )"

# fix mdx mismatch in READMEs and comments
PATCHES=( "${FILESDIR}/${PN}"-0.7.0-test-mdx.patch )
