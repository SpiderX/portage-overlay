# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/tmux-plugins/${PN}.git"

inherit git-r3

DESCRIPTION="Quickly open any path on terminal window in editor"
HOMEPAGE="https://github.com/tmux-plugins/tmux-fpp"

LICENSE="MIT"
SLOT="0"

RDEPEND="app-shells/fpp
	app-misc/tmux"

src_install() {
	einstalldocs
	insinto /usr/share/tmux-plugins/tmux-fpp
	doins fpp.tmux
	fperms +x /usr/share/tmux-plugins/tmux-fpp/fpp.tmux
}
