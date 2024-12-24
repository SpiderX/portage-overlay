# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/tmux-plugins/${PN}.git"

inherit git-r3

DESCRIPTION="Tmux plugin that displays online status"
HOMEPAGE="https://github.com/tmux-plugins/tmux-online-status"

LICENSE="MIT"
SLOT="0"

RDEPEND="app-misc/tmux"

src_install() {
	einstalldocs
	insinto /usr/share/tmux-plugins/tmux-online-status
	doins -r scripts online_status.tmux
	fperms -R +x /usr/share/tmux-plugins/tmux-online-status/scripts/online_status_icon.sh \
		/usr/share/tmux-plugins/tmux-online-status/online_status.tmux
}
