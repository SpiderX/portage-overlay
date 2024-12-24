# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Standard pane key-bindings for tmux"
HOMEPAGE="https://github.com/tmux-plugins/tmux-pain-control"
SRC_URI="https://github.com/tmux-plugins/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="app-misc/tmux"

src_install() {
	einstalldocs
	insinto /usr/share/tmux-plugins/tmux-pain-control
	doins pain_control.tmux
	fperms +x /usr/share/tmux-plugins/tmux-pain-control/pain_control.tmux
}
