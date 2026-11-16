# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit git-r3

DESCRIPTION="Use fzf to manage your tmux work environment"
HOMEPAGE="https://github.com/sainnhe/tmux-fzf"
EGIT_REPO_URI="https://github.com/sainnhe/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="app-shells/fzf
	app-misc/tmux
	sys-process/procps"

src_install() {
	einstalldocs
	insinto /usr/share/tmux-plugins/tmux-fzf
	doins -r scripts main.{sh,tmux}
	fperms -R +x /usr/share/tmux-plugins/tmux-fzf/scripts \
		/usr/share/tmux-plugins/tmux-fzf/main.{sh,tmux}
}
