# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Tmux plugin that displays online status"
HOMEPAGE="https://github.com/tmux-plugins/tmux-online-status"
SRC_URI="https://github.com/tmux-plugins/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="app-misc/tmux"

src_install() {
	einstalldocs
	insinto /usr/share/tmux-plugins/tmux-online-status
	doins -r scripts online_status.tmux
	fperms -R +x /usr/share/tmux-plugins/tmux-online-status/scripts/online_status_icon.sh \
		/usr/share/tmux-plugins/tmux-online-status/online_status.tmux
}
