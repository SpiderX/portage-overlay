# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# shellcheck disable=SC2207

EAPI=8

inherit cargo git-r3 systemd

DESCRIPTION="A spotify daemon"
HOMEPAGE="https://github.com/Spotifyd/spotifyd"
EGIT_REPO_URI="https://github.com/Spotifyd/${PN}.git"

LICENSE="0BSD Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD BSD-2 Boost-1.0 GPL-3 ISC LGPL-3 MIT MPL-2.0 Unlicense ZLIB"
SLOT="0"
IUSE="+alsa mpris-dbus portaudio pulseaudio rodio"
REQUIRED_USE="|| ( alsa portaudio pulseaudio rodio ) rodio? ( alsa )"

RDEPEND="dev-libs/openssl:0=
	alsa? ( media-libs/alsa-lib )
	mpris-dbus? ( sys-apps/dbus )
	portaudio? ( media-libs/portaudio )
	pulseaudio? ( media-libs/libpulse )"
BDEPEND="virtual/pkgconfig"

DOCS=( {CHANGELOG,README}.md )

QA_FLAGS_IGNORED="usr/bin/spotifyd"

src_unpack() {
	git-r3_src_unpack
	cargo_src_unpack
}

src_configure() {
	local myfeatures
	myfeatures=(
		$(usex alsa alsa_backend '')
		$(usex mpris-dbus "dbus_mpris" '')
		$(usex portaudio portaudio_backend '')
		$(usex pulseaudio pulseaudio_backend '')
		$(usex rodio rodio_backend '')
	)
	cargo_src_configure --no-default-features
}

src_install() {
	einstalldocs
	systemd_douserunit contrib/spotifyd.service
	newinitd "${FILESDIR}"/spotifyd.initd spotifyd
	newconfd "${FILESDIR}"/spotifyd.confd spotifyd
	insinto /etc
	doins contrib/spotifyd.conf

	cargo_src_install
}
