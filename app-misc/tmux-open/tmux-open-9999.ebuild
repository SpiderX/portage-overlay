# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit git-r3

DESCRIPTION="Tmux key bindings for quick opening of file or url"
HOMEPAGE="https://github.com/tmux-plugins/tmux-open"
EGIT_REPO_URI="https://github.com/tmux-plugins/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="app-misc/tmux
	x11-misc/xdg-utils"

src_install() {
	einstalldocs
	insinto /usr/share/tmux-plugins/tmux-open
	doins -r scripts open.tmux
	fperms +x /usr/share/tmux-plugins/tmux-open/scripts/tmux_open_error_message.sh \
			/usr/share/tmux-plugins/tmux-open/open.tmux
}
