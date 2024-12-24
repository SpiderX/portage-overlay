# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/tmux-plugins/${PN}.git"

inherit git-r3

DESCRIPTION="Tmux plugin to monitor upload and download speed"
HOMEPAGE="https://github.com/tmux-plugins/tmux-net-speed"

LICENSE="MIT"
SLOT="0"

RDEPEND="app-misc/tmux"

src_install() {
	einstalldocs
	insinto /usr/share/tmux-plugins/tmux-net-speed
	doins -r scripts init.sh net_speed.tmux
	fperms -R +x /usr/share/tmux-plugins/tmux-net-speed/scripts/{download,net,upload}_speed.sh \
		/usr/share/tmux-plugins/tmux-net-speed/init.sh \
		/usr/share/tmux-plugins/tmux-net-speed/net_speed.tmux
}
