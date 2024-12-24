# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Tmux plugin for copying to system clipboard"
HOMEPAGE="https://github.com/tmux-plugins/tmux-yank"
SRC_URI="https://github.com/tmux-plugins/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="app-misc/tmux
	|| ( x11-misc/xclip x11-misc/xsel )"

src_install() {
	einstalldocs
	insinto /usr/share/tmux-plugins/tmux-yank
	doins -r scripts yank.tmux
	fperms +x /usr/share/tmux-plugins/tmux-yank/scripts/copy_{line,pane_pwd}.sh \
			/usr/share/tmux-plugins/tmux-yank/yank.tmux
}
