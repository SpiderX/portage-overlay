# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="ffmpeg-avcodec ffmpeg-avdevice ffmpeg-avfilter ffmpeg-av
	ffmpeg-avutil ffmpeg ffmpeg-swresample ffmpeg-swscale"

inherit dune

DESCRIPTION="OCaml bindings to ffmpeg"
HOMEPAGE="https://github.com/savonet/ocaml-ffmpeg"
SRC_URI="https://github.com/savonet/${PN}/archive/v${PV}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt"

RDEPEND="media-video/ffmpeg:="
BDEPEND="dev-ml/dune-configurator:=
	virtual/pkgconfig"
