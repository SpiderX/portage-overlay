# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="Semantic Versioning module for OCaml"
HOMEPAGE="https://github.com/rgrinberg/ocaml-semver"
EGIT_REPO_URI="https://github.com/rgrinberg/ocaml-${PN}.git"

LICENSE="BSD"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

BDEPEND="test? ( dev-ml/alcotest )"
