# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Lightweight tmux utils for manipulating sessions"
HOMEPAGE="https://github.com/tmux-plugins/tmux-sessionist"
SRC_URI="https://github.com/tmux-plugins/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="app-misc/tmux"

src_install() {
	einstalldocs
	insinto /usr/share/tmux-plugins/tmux-sessionist
	doins -r scripts sessionist.tmux
	fperms -R +x /usr/share/tmux-plugins/tmux-sessionist/scripts/{goto,kill,new}_session.sh \
		/usr/share/tmux-plugins/tmux-sessionist/scripts/{kill,new}_session_prompt.sh \
		/usr/share/tmux-plugins/tmux-sessionist/scripts/{show_goto_prompt,list_sessions}.sh \
		/usr/share/tmux-plugins/tmux-sessionist/scripts/{promote_pane,switch_or_loop}.sh \
		/usr/share/tmux-plugins/tmux-sessionist/sessionist.tmux
}
