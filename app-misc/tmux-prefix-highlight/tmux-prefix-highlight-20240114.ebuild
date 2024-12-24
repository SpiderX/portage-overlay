# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="489a96189778a21d2f5f4dbbbc0ad2cec8f6c854"

DESCRIPTION="Tmux plugin for highlights by tmux prefix key"
HOMEPAGE="https://github.com/tmux-plugins/tmux-prefix-highlight"
SRC_URI="https://github.com/tmux-plugins/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="app-misc/tmux"

src_install() {
	einstalldocs
	insinto /usr/share/tmux-plugins/tmux-prefix-highlight
	doins prefix_highlight.tmux
	fperms +x /usr/share/tmux-plugins/tmux-prefix-highlight/prefix_highlight.tmux
}
