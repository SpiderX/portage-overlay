# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/savonet/${PN}.git"

inherit autotools bash-completion-r1 findlib git-r3 systemd tmpfiles

DESCRIPTION="A swiss-army knife for multimedia streaming, used for netradios and webtvs"
HOMEPAGE="http://liquidsoap.info"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="alsa ao bash-completion camlimages +camlp4 debug dssi faad fdk ffmpeg flac frei0r gavl \
	gd graphics gstreamer gui jack json ladspa lame lastfm libsamplerate \
	mad magic +ocamlopt ogg osc opus oss portaudio profiling pulseaudio sdl shine \
	shout soundtouch speex ssl systemd taglib theora +unicode vorbis xml"
REQUIRED_USE="flac? ( ogg ) lastfm? ( xml ) opus? ( ogg ) speex? ( ogg ) theora? ( ogg ) vorbis? ( ogg )"

RDEPEND="acct-user/liquidsoap
	app-admin/logrotate
	dev-lang/ocaml:=[ocamlopt?]
	>=dev-ml/ocaml-dtools-0.4.1:=[ocamlopt?]
	dev-ml/ocaml-duppy:=[ocamlopt?]
	>=dev-ml/ocaml-mm-0.4.0:=[ocamlopt?]
	dev-ml/pcre-ocaml:=
	net-misc/curl
	alsa? ( dev-ml/ocaml-alsa:=[ocamlopt?] )
	ao? ( dev-ml/ocaml-ao:=[ocamlopt?] )
	bash-completion? ( app-shells/bash-completion )
	camlimages? ( dev-ml/camlimages:= )
	camlp4? ( dev-ml/camlp4:= )
	dssi? ( dev-ml/ocaml-dssi:=[ocamlopt?] )
	faad? ( >=dev-ml/ocaml-faad-0.4.0:=[ocamlopt?] )
	fdk? ( >=dev-ml/ocaml-fdkaac-0.3.0:=[ocamlopt?] )
	ffmpeg? ( >=dev-ml/ocaml-ffmpeg-0.2.1:=[ocamlopt?] )
	flac? ( >=dev-ml/ocaml-flac-0.1.5:=[ocamlopt?,ogg?] )
	frei0r? ( dev-ml/ocaml-frei0r:=[ocamlopt?] )
	gavl? ( dev-ml/ocaml-gavl:=[ocamlopt?] )
	gd? ( dev-ml/gd4o:=[ocamlopt?]
		media-fonts/dejavu )
	gstreamer? ( >=dev-ml/ocaml-gstreamer-0.3.0:=[ocamlopt?] )
	jack? ( dev-ml/ocaml-bjack:=[ocamlopt?] )
	json? ( dev-ml/yojson:= )
	ladspa? ( dev-ml/ocaml-ladspa:=[ocamlopt?] )
	lame? ( dev-ml/ocaml-lame:=[ocamlopt?] )
	lastfm? ( dev-ml/ocaml-lastfm:=[ocamlopt?] )
	libsamplerate? ( dev-ml/ocaml-samplerate:=[ocamlopt?] )
	mad? ( dev-ml/ocaml-mad:=[ocamlopt?] )
	magic? ( dev-ml/ocaml-magic:= )
	ogg? ( dev-ml/ocaml-ogg:=[ocamlopt?] )
	opus? ( dev-ml/ocaml-opus:=[ocamlopt?] )
	osc? ( >=dev-ml/ocaml-lo-0.1.2:=[ocamlopt?] )
	portaudio? ( dev-ml/ocaml-portaudio:=[ocamlopt?] )
	pulseaudio? ( dev-ml/ocaml-pulseaudio:=[ocamlopt?] )
	sdl? ( dev-ml/ocamlsdl:=[ocamlopt?]
		media-fonts/dejavu )
	shine? ( dev-ml/ocaml-shine:=[ocamlopt?] )
	shout? ( >=dev-ml/ocaml-cry-0.6.3:=[ocamlopt?] )
	soundtouch? ( dev-ml/ocaml-soundtouch:=[ocamlopt?] )
	speex? ( dev-ml/ocaml-speex:=[ocamlopt?] )
	ssl? ( dev-ml/ocaml-ssl:= )
	taglib? ( dev-ml/ocaml-taglib:=[ocamlopt?] )
	theora? ( dev-ml/ocaml-theora:=[ocamlopt?] )
	unicode? ( >=dev-ml/camomile-1.0.2:=[ocamlopt?] )
	vorbis? ( dev-ml/ocaml-vorbis:=[ocamlopt?] )
	xml? ( dev-ml/ocaml-xmlplaylist:=[ocamlopt?] )"
DEPEND="${RDEPEND}
	dev-ml/findlib[ocamlopt?]"
BDEPEND="virtual/pkgconfig"

DOCS=( CHANGES.md README.md )

PATCHES=( "${FILESDIR}"/"${PN}"-1.4.0-configure.patch
	"${FILESDIR}"/"${PN}"-1.4.0-makefile.patch
	"${FILESDIR}"/"${PN}"-1.4.0-makefile-defs.patch )

src_prepare() {
	default

	m4/bootstrap || die "bootstrap failed"
	sed -i 's/AC_CHECK_TOOL_STRICT/AC_CHECK_TOOL/g' m4/ocaml.m4 \
		|| die "sed failed for m4/ocaml.m4"
	AT_M4DIR="m4" eautoreconf
}

src_configure() {
	econf --disable-optimize \
		--with-default-font=/usr/share/fonts/dejavu/DejaVuSans.ttf \
		--disable-gui \
		--disable-osx-secure-transport \
		--disable-winsvc \
		"$(use_enable alsa)" \
		"$(use_enable ao)" \
		"$(use_enable camlimages)" \
		"$(use_enable camlp4)" \
		"$(use_enable debug debugging)" \
		"$(use_enable dssi)" \
		"$(use_enable faad)" \
		"$(use_enable fdk fdkaac)" \
		"$(use_enable ffmpeg)" \
		"$(use_enable flac)" \
		"$(use_enable frei0r)" \
		"$(use_enable gavl)" \
		"$(use_enable gd)" \
		"$(use_enable graphics)" \
		"$(use_enable gstreamer)" \
		"$(use_enable jack bjack)" \
		"$(use_enable json yojson)" \
		"$(use_enable ladspa)" \
		"$(use_enable lame)" \
		"$(use_enable lastfm)" \
		"$(use_enable libsamplerate samplerate)" \
		"$(use_enable mad)" \
		"$(use_enable magic)" \
		"$(use_enable ocamlopt nativecode)" \
		"$(use_enable ogg)" \
		"$(use_enable opus)" \
		"$(use_enable osc lo)" \
		"$(use_enable oss)" \
		"$(use_enable portaudio)" \
		"$(use_enable pulseaudio)" \
		"$(use_enable profiling)" \
		"$(use_enable sdl)" \
		"$(use_enable shine)" \
		"$(use_enable shout cry)" \
		"$(use_enable soundtouch)" \
		"$(use_enable speex)" \
		"$(use_enable ssl)" \
		"$(use_enable taglib)" \
		"$(use_enable theora)" \
		"$(use_enable unicode camomile)" \
		"$(use_enable vorbis)" \
		"$(use_enable xml xmlplaylist)"
}

src_install() {
	findlib_src_install

	dobashcomp scripts/bash-completion
	keepdir /var/log/liquidsoap

	newtmpfiles "${FILESDIR}"/liquidsoap.tmpfile liquidsoap.conf
	newinitd "${FILESDIR}"/liquidsoap.initd liquidsoap
	systemd_dounit "${FILESDIR}"/liquidsoap.service
}

pkg_postinst() {
	tmpfiles_process liquidsoap.conf

	elog "You have to create an init script for each stream:"
	elog "ln -s liquidsoap /etc/init.d/liquidsoap.<stream>"
	elog "where script refers to /etc/liquidsoap/<stream>.liq"
}
