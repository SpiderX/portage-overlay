# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="liquidsoap liquidsoap-lang liquidsoap-js liquidsoap-mode
	prometheus-liquidsoap sdl-liquidsoap tls-liquidsoap"

inherit bash-completion-r1 dune systemd tmpfiles

DESCRIPTION="A swiss-army knife for multimedia streaming, used for netradios"
HOMEPAGE="https://github.com/savonet/liquidsoap"
SRC_URI="https://github.com/savonet/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="alsa ao camlimages ctypes dssi faad fdk ffmpeg frei0r gd graphics inotify
	irc jack jemalloc ladspa lame libsamplerate lilv lo mad memtrace +ocamlopt
	osc portaudio posix pulseaudio shine soundtouch sqlite srt ssl yaml"

RDEPEND="acct-group/liquidsoap
	acct-user/liquidsoap
	dev-ml/ca-certs:=[ocamlopt?]
	dev-ml/camomile:=[ocamlopt?]
	dev-ml/cohttp:0=[ocamlopt?]
	dev-ml/cry:0=[ocamlopt?]
	dev-ml/cstruct:0=[ocamlopt?]
	dev-ml/js_of_ocaml:0=[ocamlopt?]
	dev-ml/magic-mime:0=[ocamlopt?]
	dev-ml/menhir:0=[ocamlopt?]
	dev-ml/mem_usage:0=[ocamlopt?]
	dev-ml/metadata:0=[ocamlopt?]
	dev-ml/mirage-crypto:0=[ocamlopt?]
	dev-ml/mm:0=[ocamlopt?]
	dev-ml/ocaml-fileutils[ocamlopt?]
	dev-ml/ocurl:0=[ocamlopt?]
	dev-ml/prometheus:0=[ocamlopt?]
	dev-ml/re:0=[ocamlopt?]
	dev-ml/sedlex:0=[ocamlopt?]
	dev-ml/tls:0=[ocamlopt?]
	dev-ml/tsdl:0=[ocamlopt?]
	dev-ml/tsdl-image:0=[ocamlopt?]
	dev-ml/tsdl-ttf:0=[ocamlopt?]
	dev-ml/uri[ocamlopt?]
	dev-ml/xiph:0=[ocamlopt?]
	dev-ml/xml-light:0=[ocamlopt?]
	alsa? ( dev-ml/alsa:0=[ocamlopt?] )
	ao? ( dev-ml/ao:0=[ocamlopt?] )
	camlimages? ( dev-ml/camlimages:0=[ocamlopt?] )
	ctypes? ( dev-ml/ocaml-ctypes:0=[ocamlopt?] )
	dssi? ( dev-ml/dssi:0=[ocamlopt?] )
	faad? ( dev-ml/faad:0=[ocamlopt?] )
	fdk? ( dev-ml/fdkaac:0=[ocamlopt?] )
	ffmpeg? ( dev-ml/ffmpeg:0=[ocamlopt?] )
	frei0r? ( dev-ml/frei0r:0=[ocamlopt?] )
	gd? ( dev-ml/gd:0=[ocamlopt?]
		media-fonts/dejavu )
	graphics? ( dev-ml/graphics[ocamlopt?]
		media-fonts/dejavu )
	inotify? ( dev-ml/inotify:0=[ocamlopt?] )
	irc? ( dev-ml/irc-client:0=[ocamlopt?] )
	jack? ( dev-ml/bjack:0=[ocamlopt?] )
	jemalloc? ( dev-ml/jemalloc:0=[ocamlopt?] )
	ladspa? ( dev-ml/ladspa:0=[ocamlopt?] )
	lame? ( dev-ml/lame:0=[ocamlopt?] )
	libsamplerate? ( dev-ml/samplerate:=[ocamlopt?] )
	lilv? ( dev-ml/lilv:0=[ocamlopt?] )
	lo? ( dev-ml/lo:0=[ocamlopt?] )
	mad? ( dev-ml/mad:0=[ocamlopt?] )
	memtrace? ( dev-ml/memtrace:0=[ocamlopt?] )
	osc? ( dev-ml/osc:=[ocamlopt?] )
	portaudio? ( dev-ml/portaudio:0=[ocamlopt?] )
	posix? ( dev-ml/posix:0=[ocamlopt?] )
	pulseaudio? ( dev-ml/pulseaudio:0=[ocamlopt?] )
	shine? ( dev-ml/shine:0=[ocamlopt?] )
	soundtouch? ( dev-ml/soundtouch:0=[ocamlopt?] )
	sqlite? ( dev-ml/sqlite3:0=[ocamlopt?] )
	srt? ( dev-ml/srt:0=[ocamlopt?] )
	ssl? ( dev-ml/ocaml-ssl:0=[ocamlopt?] )
	yaml? ( dev-ml/yaml:0=[ocamlopt?] )"
BDEPEND="dev-ml/dune-build-info
	dev-ml/dune-site
	dev-ml/ppx_hash
	dev-ml/ppx_string"

src_install() {
	dune_src_install

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
