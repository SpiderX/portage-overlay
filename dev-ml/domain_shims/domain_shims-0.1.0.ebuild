# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

MY_PN="${PN/_/-}"
COMMIT="87bc2c32adad6e8d03b1e48cb7d03c851ac4f7ca"

DESCRIPTION="Domain module for OCaml 4"
HOMEPAGE="https://gitlab.com/gasche/domain-shims"
SRC_URI="https://gitlab.com/gasche/${MY_PN}/-/archive/${PV}/${P}.tar.bz2"
S="${WORKDIR}/${MY_PN}-${PV}-${COMMIT}"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt"
