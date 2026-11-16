# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit git-r3

DESCRIPTION="Quickly open any path on terminal window in editor"
HOMEPAGE="https://github.com/tmux-plugins/tmux-fpp"
EGIT_REPO_URI="https://github.com/tmux-plugins/${PN}.git"

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
