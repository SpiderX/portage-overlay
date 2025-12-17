# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="flac ogg opus speex theora vorbis"

inherit dune git-r3

DESCRIPTION="OCaml bindings for flac, ogg, opus, speex, theora, vorbis"
HOMEPAGE="https://github.com/savonet/ocaml-xiph"
EGIT_REPO_URI="https://github.com/savonet/ocaml-xiph.git"

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
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
