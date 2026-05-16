# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="Print with style in your terminal"
HOMEPAGE="https://github.com/marc-chevalier/ocolor"
EGIT_REPO_URI="https://github.com/marc-chevalier/${PN}.git"

LICENSE="MIT"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

BDEPEND="dev-ml/cppo
	test? ( dev-ml/ounit2 )"
