# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Mediastreaming library for telephony application"
HOMEPAGE="https://gitlab.linphone.org/BC/public/mediastreamer2"
SRC_URI="https://gitlab.linphone.org/BC/public/${PN}/-/archive/${PV}/${P}.tar.gz"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="alsa bv16 debug doc ffmpeg g726 g729 gsm jpeg matroska opengl opus pcap portaudio +pulseaudio qrcode speex srtp static-libs resample test theora tools +v4l vpx zrtp"
RESTRICT="!test? ( test )"
REQUIRED_USE="zrtp? ( srtp )
	resample? ( speex )
	|| ( alsa portaudio pulseaudio )
	|| ( ffmpeg opengl v4l )"

RDEPEND="net-libs/bctoolbox[test?]
	>=net-libs/ortp-5.1.3
	alsa? ( media-libs/alsa-lib )
	bv16? ( media-libs/bv16-floatingpoint )
	ffmpeg? ( media-video/ffmpeg:0= )
	g726? ( media-libs/spandsp )
	g729? ( media-libs/bcg729 )
	gsm? ( media-sound/gsm )
	jpeg? ( media-libs/libjpeg-turbo )
	matroska? ( media-libs/bcmatroska2 )
	opengl? ( media-libs/glew:0
		x11-libs/libX11
		virtual/opengl )
	opus? ( media-libs/opus )
	pcap? ( net-libs/libpcap )
	portaudio? ( media-libs/portaudio )
	pulseaudio? ( media-sound/pulseaudio )
	qrcode? ( media-libs/zxing-cpp )
	speex? ( media-libs/speex
		media-libs/speexdsp )
	srtp? ( net-libs/libsrtp:2 )
	theora? ( media-libs/libtheora )
	v4l? ( media-libs/libv4l )
	vpx? ( media-libs/libvpx:= )
	zrtp? ( net-libs/bzrtp[sqlite] )"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig
	doc? ( app-doc/doxygen )"

src_configure() {
	local mycmakeargs=(
		-DENABLE_ALSA="$(usex alsa)"
		-DENABLE_BV16="$(usex bv16)"
		-DENABLE_DEBUG_LOGS="$(usex debug)"
		-DENABLE_DOC="$(usex doc)"
		-DENABLE_FFMPEG="$(usex ffmpeg)"
		-DENABLE_G726="$(usex g726)"
		-DENABLE_G729="$(usex g729)"
		-DENABLE_G729B_CNG="$(usex g729)"
		-DENABLE_GL="$(usex opengl)"
		-DENABLE_GLX="$(usex opengl)"
		-DENABLE_GSM="$(usex gsm)"
		-DENABLE_JPEG="$(usex jpeg)"
		-DENABLE_MKV="$(usex matroska)"
		-DENABLE_OPUS="$(usex opus)"
		-DENABLE_PCAP="$(usex pcap)"
		-DENABLE_PORTAUDIO="$(usex portaudio)"
		-DENABLE_PULSEAUDIO="$(usex pulseaudio)"
		-DENABLE_QRCODE="$(usex qrcode)"
		-DENABLE_RESAMPLE="$(usex resample)"
		-DENABLE_SPEEX_CODEC="$(usex speex)"
		-DENABLE_SPEEX_DSP="$(usex speex)"
		-DENABLE_SRTP="$(usex srtp)"
		-DENABLE_STATIC="$(usex static-libs)"
		-DENABLE_THEORA="$(usex theora)"
		-DENABLE_TOOLS="$(usex tools)"
		-DENABLE_UNIT_TESTS="$(usex test)"
		-DENABLE_V4L="$(usex v4l)"
		-DENABLE_VPX="$(usex vpx)"
		-DENABLE_ZRTP="$(usex zrtp)"
	)

	cmake_src_configure
}
