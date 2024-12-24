# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="878302f228ee14f0fa59717f63743d396b327a21"

DESCRIPTION="Quickly open any path on terminal window in editor"
HOMEPAGE="https://github.com/tmux-plugins/tmux-fpp"
SRC_URI="https://github.com/tmux-plugins/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="app-shells/fpp
	app-misc/tmux"

src_install() {
	einstalldocs
	insinto /usr/share/tmux-plugins/tmux-fpp
	doins fpp.tmux
	fperms +x /usr/share/tmux-plugins/tmux-fpp/fpp.tmux
}
