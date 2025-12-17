# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

MY_PN="ocaml-${PN}"

DESCRIPTION="OCaml interface to the GD graphics library"
HOMEPAGE="https://github.com/savonet/ocaml-gd"
SRC_URI="https://github.com/savonet/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt"

RDEPEND="media-libs/gd:2[jpeg,png]
	media-libs/freetype:2
	media-libs/libjpeg-turbo:0=
	media-libs/libpng:0=
	virtual/zlib:0="
BDEPEND="dev-ml/dune-configurator
	virtual/pkgconfig"
