# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/spywhere/${PN}.git"

inherit git-r3

DESCRIPTION="A tmux-resurrect extension for named snapshot support"
HOMEPAGE="https://github.com/spywhere/tmux-named-snapshot"

LICENSE="MIT"
SLOT="0"

RDEPEND="app-misc/tmux"

src_install() {
	einstalldocs
	insinto /usr/share/tmux-plugins/tmux-named-snapshot
	doins -r scripts named-snapshot.tmux
	fperms -R +x /usr/share/tmux-plugins/tmux-named-snapshot/scripts/{restore,save}-snapshot.sh \
		/usr/share/tmux-plugins/tmux-named-snapshot/named-snapshot.tmux
}
