# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit git-r3

DESCRIPTION="Suspend local tmux session"
HOMEPAGE="https://github.com/MunifTanjim/tmux-suspend"
EGIT_REPO_URI="https://github.com/MunifTanjim/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="app-misc/tmux"

src_install() {
	einstalldocs
	insinto /usr/share/tmux-plugins/tmux-suspend
	doins -r scripts suspend.tmux
	fperms -R +x /usr/share/tmux-plugins/tmux-suspend/scripts \
		/usr/share/tmux-plugins/tmux-suspend/suspend.tmux
}
