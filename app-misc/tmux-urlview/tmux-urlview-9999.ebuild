# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit git-r3

DESCRIPTION="Quickly open any url in tmux pane"
HOMEPAGE="https://github.com/tmux-plugins/tmux-urlview"
EGIT_REPO_URI="https://github.com/tmux-plugins/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="app-misc/tmux
	app-text/extract_url"

src_install() {
	einstalldocs
	insinto /usr/share/tmux-plugins/tmux-urlview
	doins urlview.tmux
	fperms +x /usr/share/tmux-plugins/tmux-urlview/urlview.tmux
}
