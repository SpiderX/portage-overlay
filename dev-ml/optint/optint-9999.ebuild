# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="Efficient integer types on 64-bit architectures"
HOMEPAGE="https://github.com/mirage/optint"
EGIT_REPO_URI="https://github.com/ocaml-multicore/${PN}.git"

LICENSE="MIT"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

BDEPEND="test? ( dev-ml/crowbar
		dev-ml/monolith
		dev-ml/fmt )"
