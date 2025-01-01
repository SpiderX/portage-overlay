# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/rickstaa/${PN}.git"

inherit git-r3

DESCRIPTION="Tmux plugin to notify about finished processes"
HOMEPAGE="https://github.com/rickstaa/tmux-notify"

LICENSE="MIT"
SLOT="0"

RDEPEND="app-misc/tmux
	net-misc/wget
	x11-libs/libnotify"

DOCS=( {CHANGELOG,README}.md )

src_install() {
	einstalldocs
	insinto /usr/share/tmux-plugins/tmux-notify
	doins -r resources scripts tnotify.tmux
	fperms -R +x /usr/share/tmux-plugins/tmux-notify/scripts/{cancel,notify}.sh \
		/usr/share/tmux-plugins/tmux-notify/tnotify.tmux
}
