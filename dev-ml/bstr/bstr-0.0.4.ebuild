# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="bin bstr slice"

inherit dune

DESCRIPTION="A synthetic library for bigstrings"
HOMEPAGE="https://github.com/robur-coop/bstr"
SRC_URI="https://github.com/robur-coop/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt"
