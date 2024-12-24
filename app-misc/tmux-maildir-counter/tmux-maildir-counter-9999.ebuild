# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/tmux-plugins/${PN}.git"

inherit git-r3

DESCRIPTION="Plugin that counts files on a specific mail directory"
HOMEPAGE="https://github.com/tmux-plugins/tmux-maildir-counter"

LICENSE="MIT"
SLOT="0"

RDEPEND="app-misc/tmux"

src_install() {
	einstalldocs
	insinto /usr/share/tmux-plugins/tmux-maildir-counter
	doins maildir_counter.tmux
	fperms +x /usr/share/tmux-plugins/tmux-maildir-counter/maildir_counter.tmux
}
