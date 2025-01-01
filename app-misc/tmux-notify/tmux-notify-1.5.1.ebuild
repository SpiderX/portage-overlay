# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Tmux plugin to notify about finished processes"
HOMEPAGE="https://github.com/rickstaa/tmux-notify"
SRC_URI="https://github.com/rickstaa/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="app-misc/tmux
	net-misc/wget
	x11-libs/libnotify"

DOCS=( {CHANGELOG,README}.md )

src_install() {
	einstalldocs
	insinto /usr/share/tmux-plugins/tmux-notify
	doins -r resources scripts tnotify.tmux
	fperms -R +x /usr/share/tmux-plugins/tmux-notify/scripts/{cancel,notify}.sh \
		/usr/share/tmux-plugins/tmux-notify/tnotify.tmux
}
