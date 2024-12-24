# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="4b7d2b78b02315fc21eb3b8339aa180bbc8fd9c2"

DESCRIPTION="Display newsboat counters in tmux status line"
HOMEPAGE="https://github.com/tmux-plugins/tmux-newsboat"
SRC_URI="https://github.com/tmux-plugins/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="app-misc/tmux
	net-news/newsboat"

src_install() {
	einstalldocs
	insinto /usr/share/tmux-plugins/tmux-newsboat
	doins -r bin scripts newsboat.tmux
	fperms -R +x /usr/share/tmux-plugins/tmux-newsboat/bin/tmux-newsboat \
		/usr/share/tmux-plugins/tmux-newsboat/scripts/helpers.sh \
		/usr/share/tmux-plugins/tmux-newsboat/newsboat.tmux
}
