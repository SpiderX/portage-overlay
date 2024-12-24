# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/tmux-plugins/${PN}.git"

inherit git-r3

DESCRIPTION="Standard pane key-bindings for tmux"
HOMEPAGE="https://github.com/tmux-plugins/tmux-pain-control"

LICENSE="MIT"
SLOT="0"

RDEPEND="app-misc/tmux"

src_install() {
	einstalldocs
	insinto /usr/share/tmux-plugins/tmux-pain-control
	doins pain_control.tmux
	fperms +x /usr/share/tmux-plugins/tmux-pain-control/pain_control.tmux
}
