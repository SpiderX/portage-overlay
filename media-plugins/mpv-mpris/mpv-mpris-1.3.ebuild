# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit toolchain-funcs

DESCRIPTION="MPRIS plugin for mpv"
HOMEPAGE="https://github.com/hoyon/mpv-mpris"
SRC_URI="https://github.com/hoyon/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-libs/glib:2
	media-video/ffmpeg:=
	media-video/mpv[libmpv]"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig
	test? ( app-misc/jq
		media-sound/playerctl
		net-misc/socat
		sys-apps/dbus
		x11-apps/xauth
		x11-misc/xvfb-run
		x11-themes/sound-theme-freedesktop )"

src_compile() {
	tc-export CC
	emake PKG_CONFIG="$(tc-getPKG_CONFIG)"
}

src_install() {
	einstalldocs

	emake DESTDIR="${D}" PREFIX=/usr PLUGINDIR="/usr/$(get_libdir)/mpv" \
		install-system
}
