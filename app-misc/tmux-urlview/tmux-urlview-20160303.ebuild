# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="b84c876cffdd22990b4ab51247e795cbd7813d53"

DESCRIPTION="Quickly open any url in tmux pane"
HOMEPAGE="https://github.com/tmux-plugins/tmux-urlview"
SRC_URI="https://github.com/tmux-plugins/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="app-misc/tmux
	app-text/extract_url"

src_install() {
	einstalldocs
	insinto /usr/share/tmux-plugins/tmux-urlview
	doins urlview.tmux
	fperms +x /usr/share/tmux-plugins/tmux-urlview/urlview.tmux
}
