# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/tmux-plugins/${PN}.git"

inherit git-r3

DESCRIPTION="Basic tmux settings everyone can agree on"
HOMEPAGE="https://github.com/tmux-plugins/tmux-sensible"

LICENSE="MIT"
SLOT="0"

RDEPEND="app-misc/tmux"

src_install() {
	einstalldocs
	insinto /usr/share/tmux-plugins/tmux-sensible
	doins sensible.tmux
	fperms +x /usr/share/tmux-plugins/tmux-sensible/sensible.tmux
}
