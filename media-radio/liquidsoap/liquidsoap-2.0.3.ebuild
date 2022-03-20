# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

WANT_AUTOCONF="2.5"

inherit autotools bash-completion-r1 findlib systemd tmpfiles

DESCRIPTION="A swiss-army knife for multimedia streaming, used for netradios"
HOMEPAGE="https://github.com/savonet/liquidsoap"
SRC_URI="https://github.com/savonet/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="alsa ao camlimages debug dssi faad fdk ffmpeg flac frei0r gd graphics \
	gstreamer inotify jack json ladspa lame lastfm libsamplerate lilv lo \
	mad magic memtrace memusage +ocamlopt ogg osc opus oss portaudio \
	pulseaudio sdl shine shout soundtouch speex ssl srt systemd taglib \
	theora +unicode vorbis xml"
REQUIRED_USE="flac? ( ogg ) lastfm? ( xml ) opus? ( ogg ) speex? ( ogg ) theora? ( ogg ) vorbis? ( ogg )"

RDEPEND="acct-user/liquidsoap
	dev-ml/ocaml-dtools:=[ocamlopt?]
	dev-ml/ocaml-duppy:=[ocamlopt?]
	dev-ml/menhir:0=[ocamlopt?]
	<dev-ml/ocaml-mm-0.8.0:=[ocamlopt?]
	dev-ml/ocurl:=[ocamlopt?]
	dev-ml/pcre-ocaml:=[ocamlopt?]
	dev-ml/sedlex:0=[ocamlopt?]
	alsa? ( dev-ml/ocaml-alsa:=[ocamlopt?] )
	ao? ( dev-ml/ocaml-ao:=[ocamlopt?] )
	camlimages? ( dev-ml/camlimages:=[ocamlopt?] )
	dssi? ( dev-ml/ocaml-dssi:=[ocamlopt?] )
	faad? ( dev-ml/ocaml-faad:=[ocamlopt?] )
	fdk? ( dev-ml/ocaml-fdkaac:=[ocamlopt?] )
	ffmpeg? ( <dev-ml/ocaml-ffmpeg-1.1.2:=[ocamlopt?] )
	flac? ( dev-ml/ocaml-flac:=[ocamlopt?,ogg?] )
	frei0r? ( dev-ml/ocaml-frei0r:=[ocamlopt?] )
	gd? ( dev-ml/gd4o:=[ocamlopt?]
		media-fonts/dejavu )
	graphics? ( dev-ml/graphics[ocamlopt?]
		media-fonts/dejavu )
	gstreamer? ( dev-ml/ocaml-gstreamer:=[ocamlopt?] )
	inotify? ( dev-ml/ocaml-inotify:=[ocamlopt?] )
	jack? ( dev-ml/ocaml-bjack:=[ocamlopt?] )
	json? ( dev-ml/yojson:=[ocamlopt?] )
	ladspa? ( dev-ml/ocaml-ladspa:=[ocamlopt?] )
	lame? ( dev-ml/ocaml-lame:=[ocamlopt?] )
	lastfm? ( dev-ml/ocaml-lastfm:=[ocamlopt?] )
	libsamplerate? ( dev-ml/ocaml-samplerate:=[ocamlopt?] )
	lilv? ( dev-ml/ocaml-lilv:=[ocamlopt?] )
	lo? ( dev-ml/ocaml-lo:=[ocamlopt?] )
	mad? ( dev-ml/ocaml-mad:=[ocamlopt?] )
	magic? ( dev-ml/ocaml-magic:=[ocamlopt?] )
	memtrace? ( dev-ml/memtrace:=[ocamlopt?] )
	memusage? ( dev-ml/ocaml-mem_usage:=[ocamlopt?] )
	ogg? ( dev-ml/ocaml-ogg:=[ocamlopt?] )
	opus? ( dev-ml/ocaml-opus:=[ocamlopt?] )
	osc? ( dev-ml/ocaml-lo:=[ocamlopt?] )
	portaudio? ( dev-ml/ocaml-portaudio:=[ocamlopt?] )
	pulseaudio? ( dev-ml/ocaml-pulseaudio:=[ocamlopt?] )
	sdl? ( dev-ml/tsdl:=[ocamlopt?]
		media-fonts/dejavu )
	shine? ( dev-ml/ocaml-shine:=[ocamlopt?] )
	shout? ( dev-ml/ocaml-cry:=[ocamlopt?] )
	soundtouch? ( dev-ml/ocaml-soundtouch:=[ocamlopt?] )
	speex? ( dev-ml/ocaml-speex:=[ocamlopt?] )
	ssl? ( dev-ml/ocaml-ssl:=[ocamlopt?] )
	srt? ( dev-ml/ocaml-srt:=[ocamlopt?] )
	taglib? ( dev-ml/ocaml-taglib:=[ocamlopt?] )
	theora? ( dev-ml/ocaml-theora:=[ocamlopt?] )
	unicode? ( dev-ml/camomile:=[ocamlopt?] )
	vorbis? ( dev-ml/ocaml-vorbis:=[ocamlopt?] )
	xml? ( dev-ml/ocaml-xmlplaylist:=[ocamlopt?] )"
BDEPEND="virtual/pkgconfig"

PATCHES=( "${FILESDIR}"/"${P}"-configure.patch
	"${FILESDIR}"/"${P}"-makefile.patch
	"${FILESDIR}"/"${P}"-makefile-defs.patch )

src_prepare() {
	default

	sed -i "/DISTDIR/s/@version@/${PV}/" Makefile.defs.in \
		|| die "sed failed for Makefile.defs.in"
	sed -i "/version/s/@version@/${PV}/" src/META.in \
		|| die "sed failed for src/META.in"
	sed -i "s/@version@/${PV}/" doc/liquidsoap.1.md.in \
		|| die "sed failed for doc/liquidsoap.1.md.in"
	sed -i "/version=/s|\$PACKAGE_VERSION|${PV}|" configure.ac \
		|| die "sed failed for configure.ac"
	sed -i  -e "/INSTALL)  -d \$(datadir)/s|/h|-${PV}/h|" \
		-e "/cp -RfL html/s|/h|-${PV}/h|" doc/Makefile \
		|| die "sed failed for doc/Makefile"
	m4/bootstrap || die "bootstrap failed"
	sed -i 's/AC_CHECK_TOOL_STRICT/AC_CHECK_TOOL/g' m4/ocaml.m4 \
		|| die "sed failed for m4/ocaml.m4"
	AT_M4DIR="m4" eautoreconf
}

src_configure() {
	econf --disable-optimize \
		--with-default-font=/usr/share/fonts/dejavu/DejaVuSans.ttf \
		--disable-osx-secure-transport \
		--disable-winsvc \
		"$(use_enable alsa)" \
		"$(use_enable ao)" \
		"$(use_enable camlimages)" \
		"$(use_enable debug debugging)" \
		"$(use_enable dssi)" \
		"$(use_enable faad)" \
		"$(use_enable fdk fdkaac)" \
		"$(use_enable ffmpeg)" \
		"$(use_enable flac)" \
		"$(use_enable frei0r)" \
		"$(use_enable gd)" \
		"$(use_enable graphics)" \
		"$(use_enable gstreamer)" \
		"$(use_enable inotify)" \
		"$(use_enable jack bjack)" \
		"$(use_enable json yojson)" \
		"$(use_enable ladspa)" \
		"$(use_enable lame)" \
		"$(use_enable lastfm)" \
		"$(use_enable libsamplerate samplerate)" \
		"$(use_enable lilv)" \
		"$(use_enable lo)" \
		"$(use_enable mad)" \
		"$(use_enable magic)" \
		"$(use_enable memtrace)" \
		"$(use_enable memusage mem_usage)" \
		"$(use_enable ocamlopt nativecode)" \
		"$(use_enable ogg)" \
		"$(use_enable opus)" \
		"$(use_enable osc lo)" \
		"$(use_enable oss)" \
		"$(use_enable portaudio)" \
		"$(use_enable pulseaudio)" \
		"$(use_enable sdl tsdl)" \
		"$(use_enable shine)" \
		"$(use_enable shout cry)" \
		"$(use_enable soundtouch)" \
		"$(use_enable speex)" \
		"$(use_enable ssl)" \
		"$(use_enable srt)" \
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
