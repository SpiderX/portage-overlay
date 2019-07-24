# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )

inherit autotools python-single-r1 systemd tmpfiles user

DESCRIPTION="A swiss-army knife for multimedia streaming, used for netradios and webtvs"
HOMEPAGE="http://liquidsoap.fm/"
SRC_URI="https://github.com/savonet/${PN}/releases/download/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="alsa ao camlimages +camlp4 debug dssi faad fdk ffmpeg flac frei0r gavl \
	gd graphics gstreamer gui inotify jack json ladspa lame lastfm libsamplerate \
	mad magic +ocamlopt ogg osc opus oss portaudio profiling pulseaudio sdl shine \
	shout soundtouch speex ssl systemd taglib theora +unicode vorbis xml"
REQUIRED_USE="flac? ( ogg ) lastfm? ( xml ) opus? ( ogg ) speex? ( ogg ) theora? ( ogg ) vorbis? ( ogg ) ${PYTHON_REQUIRED_USE}"

RDEPEND="app-admin/logrotate
	>=dev-lang/ocaml-4.03.0:=[ocamlopt?]
	>=dev-ml/ocaml-dtools-0.4.0:=[ocamlopt?]
	>=dev-ml/ocaml-duppy-0.8.0:=[camlp4?,ocamlopt?]
	>=dev-ml/ocaml-mm-0.4.0:=[ocamlopt?]
	dev-ml/pcre-ocaml:=[ocamlopt?]
	net-misc/curl
	alsa? ( >=dev-ml/ocaml-alsa-0.2.1:=[ocamlopt?] )
	ao? ( >=dev-ml/ocaml-ao-0.2.0:=[ocamlopt?] )
	camlimages? ( >=dev-ml/camlimages-4.0.0:= )
	camlp4? ( dev-ml/camlp4:= )
	dssi? ( >=dev-ml/ocaml-dssi-0.1.1:=[ocamlopt?] )
	faad? ( >=dev-ml/ocaml-faad-0.4.0:=[ocamlopt?] )
	fdk? ( >=dev-ml/ocaml-fdkaac-0.2.1:=[ocamlopt?] )
	ffmpeg? ( >=dev-ml/ocaml-ffmpeg-0.2.1:=[ocamlopt?] )
	flac? ( >=dev-ml/ocaml-flac-0.1.4:=[ocamlopt?,ogg?]
			<dev-ml/ocaml-flac-0.1.5 )
	frei0r? ( >=dev-ml/ocaml-frei0r-0.1.0:=[ocamlopt?] )
	gavl? ( >=dev-ml/ocaml-gavl-0.1.4:=[ocamlopt?] )
	gd? ( dev-ml/gd4o:=[ocamlopt?]
		media-fonts/dejavu )
	gstreamer? ( >=dev-ml/ocaml-gstreamer-0.3.0:=[ocamlopt?] )
	gui? ( dev-python/pygtk:2[${PYTHON_USEDEP}] )
	inotify? ( >=dev-ml/ocaml-inotify-1.0:=[ocamlopt?] )
	jack? ( >=dev-ml/ocaml-bjack-0.1.5-r1:=[ocamlopt?] )
	json? ( dev-ml/yojson:= )
	ladspa? ( >=dev-ml/ocaml-ladspa-0.1.4:=[ocamlopt?] )
	lame? ( >=dev-ml/ocaml-lame-0.3.3-r1:=[ocamlopt?] )
	lastfm? ( >=dev-ml/ocaml-lastfm-0.3.0:=[ocamlopt?] )
	libsamplerate? ( >=dev-ml/ocaml-samplerate-0.1.1:=[ocamlopt?] )
	mad? ( >=dev-ml/ocaml-mad-0.4.4:=[ocamlopt?] )
	magic? ( >=dev-ml/ocaml-magic-0.6:= )
	ogg? ( >=dev-ml/ocaml-ogg-0.5.2:=[ocamlopt?] )
	opus? ( >=dev-ml/ocaml-opus-0.1.1:=[ocamlopt?] )
	osc? ( >=dev-ml/ocaml-lo-0.1.0:=[ocamlopt?] )
	portaudio? ( >=dev-ml/ocaml-portaudio-0.2.0:=[ocamlopt?] )
	pulseaudio? ( >=dev-ml/ocaml-pulseaudio-0.1.2:=[ocamlopt?] )
	sdl? ( dev-ml/ocamlsdl:=[ocamlopt?]
		   media-fonts/dejavu )
	shine? ( >=dev-ml/ocaml-shine-0.2.0:=[ocamlopt?] )
	shout? ( >=dev-ml/ocaml-cry-0.6.2:=[ocamlopt?] )
	soundtouch? ( >=dev-ml/ocaml-soundtouch-0.1.7:=[ocamlopt?] )
	speex? ( >=dev-ml/ocaml-speex-0.2.1:=[ocamlopt?] )
	ssl? ( >=dev-ml/ocaml-ssl-0.5.2:= )
	taglib? ( >=dev-ml/ocaml-taglib-0.3.0:=[ocamlopt?] )
	theora? ( >=dev-ml/ocaml-theora-0.3.1:=[ocamlopt?] )
	unicode? ( >=dev-ml/camomile-1.0.1:= )
	vorbis? ( >=dev-ml/ocaml-vorbis-0.7.0:=[ocamlopt?] )
	xml? ( >=dev-ml/ocaml-xmlplaylist-0.1.3:=[ocamlopt?] )"
DEPEND="${RDEPEND}
	dev-ml/findlib
	virtual/pkgconfig"

DOCS=( CHANGES README )

pkg_setup() {
	enewgroup liquidsoap
	enewuser liquidsoap -1 -1 /dev/null liquidsoap
}

src_prepare() {
	default

	sed -i 's/AC_CHECK_TOOL_STRICT/AC_CHECK_TOOL/g' m4/ocaml.m4 \
		|| die "Failed editing m4/ocaml.m4!"
	AT_M4DIR="m4" eautoreconf
}

src_configure() {
	econf --disable-optimize \
		--with-default-font=/usr/share/fonts/dejavu/DejaVuSans.ttf \
		"$(use_enable camlp4)" \
		"$(use_enable debug debugging)" \
		"$(use_enable graphics)" \
		"$(use_enable gui)" \
		"$(use_enable ocamlopt nativecode)" \
		"$(use_enable oss)" \
		"$(use_enable profiling)" \
		"$(use_enable unicode camomile)"
}

src_install() {
	findlib_src_preinst
	# from https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=liquidsoap
	emake \
		datadir="${ED}/usr/share/" mandir="${ED}/usr/share/man/" \
		localstatedir="${ED}/var" bindir="${ED}/usr/bin/" \
		libdir="${ED}/usr/lib/" sysconfdir="${ED}/etc/" install

	newinitd "${FILESDIR}"/liquidsoap.initd liquidsoap
	if use systemd
	then
		newtmpfiles "${FILESDIR}"/liquidsoap.tmpfile liquidsoap.conf
		systemd_dounit "${FILESDIR}"/liquidsoap.service
	fi
}

pkg_postinst() {
	if use systemd
	then
		tmpfiles_process liquidsoap.conf
	fi

	elog "You have to create an init script for each stream:"
	elog "ln -s liquidsoap /etc/init.d/liquidsoap.<stream>"
	elog "where script refers to /etc/liquidsoap/<stream>.liq"
}
