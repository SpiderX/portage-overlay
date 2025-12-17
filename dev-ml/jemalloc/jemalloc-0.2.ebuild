# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

MY_PN="ocaml-${PN}"

DESCRIPTION="Bindings to jemalloc mallctl api"
HOMEPAGE="https://github.com/ahrefs/ocaml-jemalloc"
SRC_URI="https://github.com/ahrefs/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt"

DEPEND="dev-libs/jemalloc:0="
