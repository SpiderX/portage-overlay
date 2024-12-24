# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/tmux-plugins/${PN}.git"

inherit git-r3

DESCRIPTION="Persists tmux environment across system restarts"
HOMEPAGE="https://github.com/tmux-plugins/tmux-resurrect"

LICENSE="MIT"
SLOT="0"
IUSE="gdbm neovim vim"

RDEPEND="app-misc/tmux
	sys-process/procps
	gdbm? ( sys-libs/gdbm:= )
	neovim? ( app-editors/neovim )
	vim? ( app-editors/vim-core )"

src_install() {
	einstalldocs
	insinto /usr/share/tmux-plugins/tmux-resurrect
	doins -r save_command_strategies scripts strategies resurrect.tmux
	fperms -R +x /usr/share/tmux-plugins/tmux-resurrect/{save_command_,}strategies/ \
			/usr/share/tmux-plugins/tmux-resurrect/scripts/check_tmux_version.sh \
			/usr/share/tmux-plugins/tmux-resurrect/scripts/restore.{exp,sh} \
			/usr/share/tmux-plugins/tmux-resurrect/scripts/{save,tmux_spinner}.sh \
			/usr/share/tmux-plugins/tmux-resurrect/resurrect.tmux
}
