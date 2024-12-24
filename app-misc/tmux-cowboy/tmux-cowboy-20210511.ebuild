# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="75702b6d0a866769dd14f3896e9d19f7e0acd4f2"

DESCRIPTION="Kill hanging processes fast inside tmux pane"
HOMEPAGE="https://github.com/tmux-plugins/tmux-cowboy"
SRC_URI="https://github.com/tmux-plugins/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="app-misc/tmux
	sys-process/procps"

src_install() {
	einstalldocs
	insinto /usr/share/tmux-plugins/tmux-cowboy
	doins -r scripts cowboy.tmux
	fperms -R +x /usr/share/tmux-plugins/tmux-cowboy/scripts/kill.sh \
		/usr/share/tmux-plugins/tmux-cowboy/cowboy.tmux
}
