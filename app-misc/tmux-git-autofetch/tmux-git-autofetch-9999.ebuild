# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit git-r3

DESCRIPTION="Automatically fetches current opened git repositories"
HOMEPAGE="https://github.com/thepante/tmux-git-autofetch"
EGIT_REPO_URI="https://github.com/thepante/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="app-misc/tmux
	dev-vcs/git"

src_install() {
	einstalldocs
	insinto /usr/share/tmux-plugins/tmux-git-autofetch
	doins git-autofetch.tmux
	fperms +x /usr/share/tmux-plugins/tmux-git-autofetch/git-autofetch.tmux
}
