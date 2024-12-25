# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Automatically reload your tmux config file on change"
HOMEPAGE="https://github.com/b0o/tmux-autoreload"
SRC_URI="https://github.com/b0o/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="app-admin/entr
	app-misc/tmux"

src_install() {
	einstalldocs
	insinto /usr/share/tmux-plugins/tmux-autoreload
	doins tmux-autoreload.tmux
	fperms +x /usr/share/tmux-plugins/tmux-autoreload/tmux-autoreload.tmux
}
