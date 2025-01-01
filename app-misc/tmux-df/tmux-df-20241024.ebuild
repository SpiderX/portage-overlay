# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="bf2049d74bc252681047438ebdc783c3b2f8a405"

DESCRIPTION="Tmux plugin to show disk space in the statusbar"
HOMEPAGE="https://github.com/tassaron/tmux-df"
SRC_URI="https://github.com/tassaron/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="app-misc/tmux"

src_install() {
	einstalldocs
	insinto /usr/share/tmux-plugins/tmux-df
	doins df.tmux
	fperms +x /usr/share/tmux-plugins/tmux-df/df.tmux
}
