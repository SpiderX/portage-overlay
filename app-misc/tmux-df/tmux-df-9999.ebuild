# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/tmux-plugins/${PN}.git"

inherit git-r3

DESCRIPTION="Tmux plugin to show disk space in the statusbar"
HOMEPAGE="https://github.com/tassaron/tmux-df"

LICENSE="MIT"
SLOT="0"

RDEPEND="app-misc/tmux"

src_install() {
	einstalldocs
	insinto /usr/share/tmux-plugins/tmux-df
	doins df.tmux
	fperms +x /usr/share/tmux-plugins/tmux-df/df.tmux
}
