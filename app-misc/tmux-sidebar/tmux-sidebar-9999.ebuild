# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/tmux-plugins/${PN}.git"

inherit git-r3

DESCRIPTION="A sidebar with the directory tree for tmux"
HOMEPAGE="https://github.com/tmux-plugins/tmux-sessionist"

LICENSE="MIT"
SLOT="0"

RDEPEND="app-misc/tmux"

src_install() {
	einstalldocs
	insinto /usr/share/tmux-plugins/tmux-sidebar
	doins -r scripts sidebar.tmux
	fperms -R +x /usr/share/tmux-plugins/tmux-sidebar/scripts/check_tmux_version.sh \
		/usr/share/tmux-plugins/tmux-sidebar/scripts/{custom_tree,save_sidebar_width}.sh \
		/usr/share/tmux-plugins/tmux-sidebar/scripts/toggle.sh \
		/usr/share/tmux-plugins/tmux-sidebar/sidebar.tmux
}
