# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit git-r3

DESCRIPTION="Display newsboat counters in tmux status line"
HOMEPAGE="https://github.com/tmux-plugins/tmux-newsboat"
EGIT_REPO_URI="https://github.com/tmux-plugins/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="app-misc/tmux
	net-news/newsboat"

src_install() {
	einstalldocs
	insinto /usr/share/tmux-plugins/tmux-newsboat
	doins -r bin scripts newsboat.tmux
	fperms -R +x /usr/share/tmux-plugins/tmux-newsboat/bin/tmux-newsboat \
		/usr/share/tmux-plugins/tmux-newsboat/scripts/helpers.sh \
		/usr/share/tmux-plugins/tmux-newsboat/newsboat.tmux
}
