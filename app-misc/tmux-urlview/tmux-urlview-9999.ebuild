# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/tmux-plugins/${PN}.git"

DESCRIPTION="Quickly open any url in tmux pane"
HOMEPAGE="https://github.com/tmux-plugins/tmux-urlview"

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
