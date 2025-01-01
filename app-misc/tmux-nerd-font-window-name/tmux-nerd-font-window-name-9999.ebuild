# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/joshmedeski/${PN}.git"

inherit git-r3

DESCRIPTION="Nerd Font icons for your tmux windows"
HOMEPAGE="https://github.com/joshmedeski/tmux-nerd-font-window-name"

LICENSE="MIT"
SLOT="0"

RDEPEND="app-misc/tmux
	|| ( app-misc/yq app-misc/yq-go )"

src_install() {
	einstalldocs
	insinto /usr/share/tmux-plugins/tmux-nerd-font-window-name
	doins -r bin tmux-nerd-font-window-name.tmux
	fperms +x /usr/share/tmux-plugins/tmux-nerd-font-window-name/bin/tmux-nerd-font-window-name \
		/usr/share/tmux-plugins/tmux-nerd-font-window-name/tmux-nerd-font-window-name.tmux
}
