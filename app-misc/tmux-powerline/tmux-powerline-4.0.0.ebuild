# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# shellcheck disable=SC2086

EAPI=9

inherit flag-o-matic toolchain-funcs

DESCRIPTION="A hackable status bar for tmux"
HOMEPAGE="https://github.com/erikw/tmux-powerline"
SRC_URI="https://github.com/erikw/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="mbox mpd X"

RDEPEND="app-alternatives/bc
	app-misc/jq
	app-misc/tmux
	app-misc/tmux-mem-cpu-load
	net-misc/curl
	mbox? ( net-mail/mailcheck )
	mpd? ( media-libs/libmpdclient )
	X? ( x11-libs/libX11
		x11-libs/libXau
		x11-libs/libXdmcp
		x11-libs/libxcb:= )"

src_compile() {
	if use mpd ; then
		append-libs -lmpdclient
		edo "$(tc-getCC)" ${CFLAGS} \
			-o segments/np_mpd segments/np_mpd.c ${LDFLAGS} ${LIBS}
	fi
	if use X ; then
		append-libs -lX11
		edo "$(tc-getCC)" ${CFLAGS} \
			-o segments/xkb_layout segments/xkb_layout.c ${LDFLAGS} ${LIBS}
	fi
}

src_install() {
	einstalldocs
	insinto /usr/share/tmux-plugins/tmux-powerline
	doins -r config lib scripts themes main.tmux {color_palette,doctor,generate_config}.sh {,mute_}powerline.sh
	insinto /usr/share/tmux-plugins/tmux-powerline/segments
	doins segments/*.{script,sh,py}
	fperms -R +x /usr/share/tmux-plugins/tmux-powerline/scripts \
		/usr/share/tmux-plugins/tmux-powerline/segments/{battery,cpu,date,date_day,date_week,disk_usage}.sh \
		/usr/share/tmux-plugins/tmux-powerline/segments/{air,earthquake,gcalcli,hostname,ifstat,ifstat_sys}.sh \
		/usr/share/tmux-plugins/tmux-powerline/segments/{lan_ip,load,macos_notification_count}.sh \
		/usr/share/tmux-plugins/tmux-powerline/segments/{mailcount,now_playing}.sh \
		/usr/share/tmux-plugins/tmux-powerline/segments/np_pithos.py \
		/usr/share/tmux-plugins/tmux-powerline/segments/mailcount_apple_mail.script \
		/usr/share/tmux-plugins/tmux-powerline/segments/np_{apple_music,itunes,rdio_mac,spotify_mac}.script \
		/usr/share/tmux-plugins/tmux-powerline/segments/{pwd,rainbarf,time,uptime,utc_time}.sh \
		/usr/share/tmux-plugins/tmux-powerline/segments/tmux_{mem_cpu_load,session_info}.sh \
		/usr/share/tmux-plugins/tmux-powerline/segments/vcs_{branch,compare,modified,others}.sh \
		/usr/share/tmux-plugins/tmux-powerline/segments/vcs_{revision,rootpath,staged}.sh \
		/usr/share/tmux-plugins/tmux-powerline/segments/{wan_ip,weather,xkb_layout}.sh \
		/usr/share/tmux-plugins/tmux-powerline/{color_palette,doctor,generate_config}.sh \
		/usr/share/tmux-plugins/tmux-powerline/{mute_,}powerline.sh \
		/usr/share/tmux-plugins/tmux-powerline/main.tmux

	if use mpd ; then
		doins np_mpd
		fperms +x /usr/share/tmux-plugins/tmux-powerline/segments/np_mpd
	fi
	if use X ; then
		doins segments/xkb_layout
		fperms +x /usr/share/tmux-plugins/tmux-powerline/segments/xkb_layout
	fi
}
