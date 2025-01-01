# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Nerd Font icons for your tmux windows"
HOMEPAGE="https://github.com/joshmedeski/tmux-nerd-font-window-name"
SRC_URI="https://github.com/joshmedeski/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="app-misc/tmux
	|| ( app-misc/yq app-misc/yq-go )"

src_install() {
	einstalldocs
	insinto /usr/share/tmux-plugins/tmux-nerd-font-window-name
	doins -r bin tmux-nerd-font-window-name.tmux
	fperms +x /usr/share/tmux-plugins/tmux-nerd-font-window-name/bin/tmux-nerd-font-window-name \
		/usr/share/tmux-plugins/tmux-nerd-font-window-name/tmux-nerd-font-window-name.tmux
}
