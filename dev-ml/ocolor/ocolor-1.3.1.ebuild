# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Print with style in your terminal"
HOMEPAGE="https://github.com/marc-chevalier/ocolor"
SRC_URI="https://github.com/marc-chevalier/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

BDEPEND="dev-ml/cppo
	test? ( dev-ml/ounit2 )"
