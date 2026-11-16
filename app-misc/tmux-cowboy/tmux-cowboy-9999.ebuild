# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit git-r3

DESCRIPTION="Kill hanging processes fast inside tmux pane"
HOMEPAGE="https://github.com/tmux-plugins/tmux-cowboy"
EGIT_REPO_URI="https://github.com/tmux-plugins/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="app-misc/tmux
	sys-process/procps"

src_install() {
	einstalldocs
	insinto /usr/share/tmux-plugins/tmux-cowboy
	doins -r scripts cowboy.tmux
	fperms -R +x /usr/share/tmux-plugins/tmux-cowboy/scripts/kill.sh \
		/usr/share/tmux-plugins/tmux-cowboy/cowboy.tmux
}
