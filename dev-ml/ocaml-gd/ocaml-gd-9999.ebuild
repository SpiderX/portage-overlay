# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="gd"

inherit dune git-r3

DESCRIPTION="OCaml interface to the GD graphics library"
HOMEPAGE="https://github.com/savonet/ocaml-gd"
EGIT_REPO_URI="https://github.com/savonet/${PN}.git"

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
IUSE="+ocamlopt"

RDEPEND="dev-ml/dune-configurator:=[ocamlopt?]
	media-libs/gd[jpeg,png]
	media-libs/freetype:2
	media-libs/libjpeg-turbo:0=
	media-libs/libpng:0=
	virtual/zlib:0="
BDEPEND="virtual/pkgconfig"
