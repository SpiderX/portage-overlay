# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="flac ogg opus speex theora vorbis"

inherit dune

MY_PN="ocaml-${PN}"

DESCRIPTION="OCaml bindings for flac, ogg, opus, speex, theora, vorbis"
HOMEPAGE="https://github.com/savonet/ocaml-xiph"
SRC_URI="https://github.com/savonet/${MY_PN}/archive/v${PV}/${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt"

RDEPEND="!dev-ml/flac
	!dev-ml/ogg
	!dev-ml/opus
	!dev-ml/speex
	!dev-ml/theora
	!dev-ml/vorbis
	media-libs/flac:0=[ogg]
	media-libs/libogg
	media-libs/opus
	media-libs/speex
	media-libs/libtheora:0=
	media-libs/libvorbis"
BDEPEND="dev-ml/dune-configurator
	virtual/pkgconfig"
