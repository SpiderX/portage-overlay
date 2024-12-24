# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/tmux-plugins/${PN}.git"

inherit git-r3

DESCRIPTION="Kill hanging processes fast inside tmux pane"
HOMEPAGE="https://github.com/tmux-plugins/tmux-cowboy"

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
