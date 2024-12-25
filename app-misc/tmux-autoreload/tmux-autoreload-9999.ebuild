# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/b0o/${PN}.git"

inherit git-r3

DESCRIPTION="Automatically reload your tmux config file on change"
HOMEPAGE="https://github.com/b0o/tmux-autoreload"

LICENSE="MIT"
SLOT="0"

RDEPEND="app-admin/entr
	app-misc/tmux"

src_install() {
	einstalldocs
	insinto /usr/share/tmux-plugins/tmux-autoreload
	doins tmux-autoreload.tmux
	fperms +x /usr/share/tmux-plugins/tmux-autoreload/tmux-autoreload.tmux
}
